#!/usr/bin/env python3
"""
Scan all FHIR resource definitions and identify field/datatype naming conflicts.
Generates a report table showing resources where element field names match their datatypes.
"""

import os
import re
import csv
import sys
from pathlib import Path
from html.parser import HTMLParser

class ElementExtractor(HTMLParser):
    """Parse HTML resource definition tables to extract element names and types."""
    
    def __init__(self):
        super().__init__()
        self.elements = []
        self.current_row = []
        self.in_table = False
        self.in_td = False
        self.current_cell = []
        self.capture = False
        
    def handle_starttag(self, tag, attrs):
        if tag == 'table':
            # Check if this is the element definition table
            for attr, value in attrs:
                if attr == 'class' and 'grid' in value:
                    self.in_table = True
                    self.capture = True
        elif tag == 'td' and self.in_table:
            self.in_td = True
            self.current_cell = []
        elif tag == 'tr' and self.in_table:
            self.current_row = []
            
    def handle_endtag(self, tag):
        if tag == 'table' and self.in_table:
            self.in_table = False
            self.capture = False
        elif tag == 'td' and self.in_td:
            self.in_td = False
            cell_text = ''.join(self.current_cell).strip()
            self.current_row.append(cell_text)
        elif tag == 'tr' and self.in_table and len(self.current_row) > 0:
            # Process completed row
            if len(self.current_row) >= 2:
                name = self.current_row[0]
                data_type = self.current_row[1] if len(self.current_row) > 1 else ''
                if name and data_type:
                    self.elements.append({
                        'name': name.split('[')[0].strip(),  # Handle slices like name[slice]
                        'type': data_type.split('|')[0].strip(),  # Handle union types
                    })
            self.current_row = []
            
    def handle_data(self, data):
        if self.in_td:
            self.current_cell.append(data)

def normalize_name(name):
    """Normalize name for comparison (lowercase, remove special chars)."""
    return re.sub(r'[^a-z0-9]', '', name.lower())

def extract_resource_elements(html_file, resource_name):
    """Extract element definitions from a resource HTML file."""
    try:
        with open(html_file, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
            
        # More robust parsing: look for element definition patterns
        # Pattern: element name in bold followed by type in the same row
        pattern = r'<tr[^>]*>.*?<td[^>]*>.*?<strong>([^<]+)</strong>.*?</td>.*?<td[^>]*>([^<]+)</td>'
        
        elements = []
        for match in re.finditer(pattern, content, re.DOTALL):
            elem_name = match.group(1).strip().split('[')[0]  # Handle slices
            elem_type = match.group(2).strip().split('|')[0]  # Handle union types
            
            if elem_name and elem_type and elem_name[0].islower():  # Skip resource header rows
                elements.append({
                    'name': elem_name,
                    'type': elem_type,
                })
        
        return elements
    except Exception as e:
        print(f"Error processing {html_file}: {e}", file=sys.stderr)
        return []

def find_naming_conflicts(publish_dir):
    """Find all resource naming conflicts."""
    conflicts = []
    resource_files = sorted(Path(publish_dir).glob('*.html'))
    
    for html_file in resource_files:
        resource_name = html_file.stem
        
        # Skip non-resource files
        if resource_name.startswith('v3-') or resource_name.startswith('v2-') or \
           resource_name in ['index', 'qa', 'toc'] or \
           '-definitions' in resource_name or '-examples' in resource_name or \
           '-search' in resource_name:
            continue
        
        elements = extract_resource_elements(str(html_file), resource_name)
        
        for elem in elements:
            elem_name_norm = normalize_name(elem['name'])
            elem_type_norm = normalize_name(elem['type'])
            
            # Check for exact match (case-insensitive)
            if elem_name_norm and elem_type_norm and elem_name_norm == elem_type_norm:
                conflicts.append({
                    'resource': resource_name,
                    'field_path': f"{resource_name}.{elem['name']}",
                    'field_name': elem['name'],
                    'datatype': elem['type'],
                    'match_type': 'exact',
                })
            # Check for substring/stem match
            elif elem_name_norm and elem_type_norm and \
                 (elem_name_norm in elem_type_norm or elem_type_norm in elem_name_norm):
                conflicts.append({
                    'resource': resource_name,
                    'field_path': f"{resource_name}.{elem['name']}",
                    'field_name': elem['name'],
                    'datatype': elem['type'],
                    'match_type': 'substring',
                })
    
    return conflicts

def main():
    publish_dir = Path('/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish')
    
    if not publish_dir.exists():
        print(f"Error: {publish_dir} not found", file=sys.stderr)
        sys.exit(1)
    
    print("Scanning FHIR resource definitions for naming conflicts...")
    conflicts = find_naming_conflicts(str(publish_dir))
    
    # Filter to only exact matches (highest priority)
    exact_conflicts = [c for c in conflicts if c['match_type'] == 'exact']
    substring_conflicts = [c for c in conflicts if c['match_type'] == 'substring']
    
    print(f"\n## FHIR Resource Field/Datatype Naming Conflicts\n")
    print(f"**Total Conflicts Found:** {len(conflicts)} ({len(exact_conflicts)} exact, {len(substring_conflicts)} substring)\n")
    
    if exact_conflicts:
        print("### Exact Matches (Field Name = Type Name, Case-Insensitive)\n")
        print("| Resource | Field Path | Field Name | Datatype | Severity |")
        print("|----------|-----------|-----------|----------|----------|")
        for c in sorted(exact_conflicts, key=lambda x: x['resource']):
            print(f"| {c['resource']} | `{c['field_path']}` | `{c['field_name']}` | `{c['datatype']}` | error |")
        print()
    
    if substring_conflicts:
        print("### Substring Matches (Semantic Overlap)\n")
        print("| Resource | Field Path | Field Name | Datatype | Severity |")
        print("|----------|-----------|-----------|----------|----------|")
        for c in sorted(substring_conflicts, key=lambda x: x['resource']):
            print(f"| {c['resource']} | `{c['field_path']}` | `{c['field_name']}` | `{c['datatype']}` | warning |")
        print()
    
    if not conflicts:
        print("No naming conflicts detected.\n")
    
    # Write to CSV for further analysis
    csv_file = 'fhir-naming-conflicts.csv'
    with open(csv_file, 'w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=['resource', 'field_path', 'field_name', 'datatype', 'match_type'])
        writer.writeheader()
        writer.writerows(sorted(conflicts, key=lambda x: (x['resource'], x['field_path'])))
    
    print(f"Full results written to: {csv_file}")
    return 0 if conflicts else 1

if __name__ == '__main__':
    sys.exit(main())

#!/usr/bin/env python3
"""Scan FHIR StructureDefinitions for field/datatype naming conflicts."""
import re
import csv
import sys
from pathlib import Path
from xml.etree import ElementTree as ET

def normalize_name(name):
    """Normalize name for comparison (lowercase, remove special chars)."""
    return re.sub(r'[^a-z0-9]', '', name.lower())

def strip_ns(tag):
    """Remove XML namespace from tag name."""
    return tag.split('}')[-1] if '}' in tag else tag

def extract_elements_from_xml(xml_file):
    """Extract element definitions from StructureDefinition XML."""
    elements = []
    try:
        tree = ET.parse(xml_file)
        root = tree.getroot()
        
        # Iterate through all elements in the XML document
        for element in root.iter():
            # Strip namespace from tag
            tag = strip_ns(element.tag)
            
            # Only look at element nodes
            if tag != 'element':
                continue
            
            elem_id = element.get('id', '')
            # We can use id as the path, it contains resource.field format
            if '.' not in elem_id:
                continue
            
            path = elem_id
            field_name = path.split('.')[-1].split('[')[0]
            
            # Find type code within this element
            code_value = None
            for child in element:
                child_tag = strip_ns(child.tag)
                if child_tag == 'type':
                    # Type element has nested code element with value attribute
                    for subchild in child:
                        subchild_tag = strip_ns(subchild.tag)
                        if subchild_tag == 'code':
                            code_value = subchild.get('value')
                            break
                    if code_value:
                        break
            
            if code_value:
                code_value = code_value.split('|')[0].strip()
                elements.append({
                    'path': path,
                    'field_name': field_name,
                    'type': code_value,
                })
    except Exception as e:
        pass
    
    return elements

def find_conflicts():
    """Find all resource naming conflicts by scanning XML."""
    conflicts = []
    source_dir = Path('/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source')
    
    if not source_dir.exists():
        print(f"Error: {source_dir} not found", file=sys.stderr)
        return []
    
    # Find all structuredefinition-*.xml files
    xml_files = sorted(source_dir.glob('*/structuredefinition-*.xml'))
    total = len(xml_files)
    processed = 0
    
    print(f"Found {total} resource definitions", file=sys.stderr)
    
    for xml_file in xml_files:
        processed += 1
        if processed % 10 == 0:
            print(f"  [{processed}/{total}] {xml_file.parent.name}...", file=sys.stderr, flush=True)
        
        resource_name = xml_file.parent.name
        elements = extract_elements_from_xml(str(xml_file))
        
        for elem in elements:
            # Skip root resource name element
            if '.' not in elem['path']:
                continue
            
            field_name_norm = normalize_name(elem['field_name'])
            elem_type_norm = normalize_name(elem['type'])
            
            # Skip empty
            if not field_name_norm or not elem_type_norm:
                continue
            
            # Check for exact match
            if field_name_norm == elem_type_norm:
                conflicts.append({
                    'resource': resource_name,
                    'field_path': elem['path'],
                    'field_name': elem['field_name'],
                    'datatype': elem['type'],
                    'severity': 'error',
                })
            # Check substring matches
            elif field_name_norm in elem_type_norm or elem_type_norm in field_name_norm:
                conflicts.append({
                    'resource': resource_name,
                    'field_path': elem['path'],
                    'field_name': elem['field_name'],
                    'datatype': elem['type'],
                    'severity': 'warning',
                })
    
    print(f"Scan complete: {processed} resources processed", file=sys.stderr)
    return conflicts

def generate_report(conflicts):
    """Generate markdown report."""
    if not conflicts:
        print("\n## FHIR Resource Field/Datatype Naming Conflicts\n")
        print("**No conflicts found.**\n")
        return
    
    # Separate by severity
    exact = [c for c in conflicts if c['severity'] == 'error']
    substring = [c for c in conflicts if c['severity'] == 'warning']
    
    print(f"\n## FHIR Resource Field/Datatype Naming Conflicts\n")
    print(f"**Total conflicts: {len(conflicts)}** (Exact: {len(exact)}, Substring: {len(substring)})\n")
    
    if exact:
        print("### Exact Matches (Field Name = Datatype)\n")
        print("| Resource | Field Path | Field Name | Datatype | Severity |")
        print("|----------|-----------|-----------|----------|----------|")
        for c in sorted(exact, key=lambda x: x['resource']):
            print(f"| `{c['resource']}` | `{c['field_path']}` | `{c['field_name']}` | `{c['datatype']}` | ERROR |")
        print()
    
    if substring:
        print("### Substring Matches (Semantic Overlap)\n")
        print("| Resource | Field Path | Field Name | Datatype | Severity |")
        print("|----------|-----------|-----------|----------|----------|")
        for c in sorted(substring, key=lambda x: x['resource']):
            print(f"| `{c['resource']}` | `{c['field_path']}` | `{c['field_name']}` | `{c['datatype']}` | WARNING |")
        print()

def export_csv(conflicts):
    """Export conflicts to CSV."""
    if not conflicts:
        return
    
    csv_file = Path('/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-naming-conflicts.csv')
    
    try:
        with open(csv_file, 'w', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=['resource', 'field_path', 'field_name', 'datatype', 'severity'])
            writer.writeheader()
            writer.writerows(conflicts)
        
        print(f"CSV export: {csv_file}", file=sys.stderr)
    except Exception as e:
        print(f"Error writing CSV: {e}", file=sys.stderr)

if __name__ == '__main__':
    conflicts = find_conflicts()
    generate_report(conflicts)
    export_csv(conflicts)
    sys.exit(0)

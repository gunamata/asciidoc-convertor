import json
import re
import sys
import os

def extract_json_from_js(js_content):
    no_comments = re.sub(r'^\s*//.*\n?', '', js_content, flags=re.MULTILINE)
    json_match = re.search(r'const sidebars = (\{.*\n(?:.|\n)*?\})', no_comments, re.DOTALL)
    
    if json_match:
        json_str = re.sub(r'(\w+):', r'"\1":', json_match.group(1)).replace('\n', '').replace("'", '"')
        json_str = re.sub(r',\s*([\]}])', r'\1', json_str)
        return json.loads(json_str)
    return None

def does_doc_file_contain_title_slug(file_path):
    if os.path.exists(file_path):
        with open(file_path, 'r') as file:
            content = file.read()
        pattern = re.compile(r'^title:\s+.+', re.MULTILINE)
        match = pattern.search(content)
        if match:
            return True
        else:
            return False
    else:
        return False
    

def format_item(base_path, prefix, label, link_id=None):
    if link_id:
        root, ext = os.path.splitext(link_id)
        file_path = base_path + "/" + root + ".md"
        if(does_doc_file_contain_title_slug(file_path)):
            return f"{prefix}xref:{link_id}.adoc[]"
        else:
            return f"{prefix}xref:{link_id}.adoc[{label}]"
    return f"{prefix}{label}"

def process_items(base_path, items, depth=1):
    result = []
    prefix = '*' * depth + ' '
    
    for item in items:
        if isinstance(item, str):
            result.append(format_item(base_path, prefix, item.split('/')[-1].replace('-', ' ').title(), item))
        elif isinstance(item, dict):
            label = item.get('label', 'Category')
            if 'link' in item:
                result.append(format_item(base_path, prefix, label, item['link']['id']))
            if 'items' in item:
                if 'link' not in item:
                    result.append(format_item(base_path, prefix, label))
                result.extend(process_items(base_path, item['items'], depth + 1))
    return result

def main():
    if len(sys.argv) != 2:
        print('Usage: python nav.py sidebar.js')
        sys.exit(1)
        
    if "versioned_" in sys.argv[1]:
        base_path = "./kramdown_md_to_asciidoc/versioned_docs/" + os.path.splitext(os.path.basename(sys.argv[1]))[0]
    else:
        base_path = "./kramdown_md_to_asciidoc/docs"
        
    sidebar_path = sys.argv[1]
    nav_path = os.path.splitext(sidebar_path)[0] + '.adoc'
    
    with open(sidebar_path, 'r', encoding='utf-8') as f:
        if "versioned_" in sys.argv[1]:
            sidebar = json.loads(f.read())
        else:
            sidebar = extract_json_from_js(f.read())
    
    nav_content = []
    for key, sections in sidebar.items():
        nav_content.extend(process_items(base_path, sections))
    
    with open(nav_path, 'w') as f:
        f.write("\n".join(nav_content))

if __name__ == '__main__':
    main()

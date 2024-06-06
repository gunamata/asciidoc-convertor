#!/bin/bash

function collapsible_blocks_ds2ad {
local f="$1"

python3 -c "
import re
import sys

def replace_match(match):
    summary_text = match.group(1)
    detail_content = match.group(2).strip()
    return f\".{summary_text}\n[%collapsible]\n====\n{detail_content}\n====\"

def collapsible_blocks_ds2ad(adt):
    # Convert collapsible blocks from Docusaurus to Asciidoctor
    pattern = re.compile(r'<details id=\"[^\"]+\">\s*<summary>([^<]+)</summary>\s*([\s\S]*?)\s*</details>')
    modified_content = pattern.sub(replace_match, adt)

    return modified_content


def main():
    if len(sys.argv) != 2:
        print('Usage: python admon.py input.md')
        sys.exit(1)

    ip_file = sys.argv[1]

    with open(ip_file, 'r', encoding='utf-8') as f:
        md_in = f.read()
        f.close()

    md_out = collapsible_blocks_ds2ad(md_in)

    with open(ip_file, 'w', encoding='utf-8') as f:
        f.write(md_out)
        f.close()


if __name__ == '__main__':
    main()
" "$f"
}

collapsible_blocks_ds2ad "$1"
#Convert DS collapsible blocks to AD collapsible blocks

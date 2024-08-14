#!/bin/bash

function tabs_ds2ad {
local f="$1"

python3 -c "
import re
import sys

def tabs_ds2ad(adt):
    # Convert tabs from Docusaurus to Asciidoctor
    replacements = [
        (r'(\+)*<Tabs>(\+)*', '\n\n[tabs]\n======'),
        (r'(\+)*<Tabs groupId=\"([^\"]+)\">(\+)*', r'\n\n[tabs,sync-group-id=\\2]\n======'),
        (r'======(\+)*<TabItem value=\"([^\"]+)\" label=\"([^\"]+)\"( default=\"\")?>(\+)*', r'======\nTab \\3::\n+\n'),
        (r'======(\+)*<TabItem value=\"([^\"]+)\"( default=\"\")?>(\+)*', r'======\nTab \\2::\n+\n'),
        (r'(\+)*<TabItem value=\"([^\"]+)\" label=\"([^\"]+)\"( default=\"\")?>(\+)*', r'\n\nTab \\3::\n+\n'),
        (r'(\+)*<TabItem value=\"([^\"]+)\"( default=\"\")?>(\+)*', r'\n\nTab \\2::\n+\n'),
        (r'(\+)*</TabItem>(\+)*', ''),
        (r'(\+)*</Tabs>(\+)*', '\n======')
    ]

    for pattern, replacement in replacements:
        adt = re.sub(pattern, replacement, adt)

    return adt

def main():
    if len(sys.argv) != 2:
        print('Usage: python admon.py input.md')
        sys.exit(1)

    ip_file = sys.argv[1]

    with open(ip_file, 'r', encoding='utf-8') as f:
        md_in = f.read()
        f.close()

    md_out = tabs_ds2ad(md_in)

    with open(ip_file, 'w', encoding='utf-8') as f:
        f.write(md_out)
        f.close()


if __name__ == '__main__':
    main()
" "$f"
}

tabs_ds2ad "$1"
#Convert DS tabs to AD tabs (https://github.com/asciidoctor/asciidoctor-tabs)

#!/bin/bash

function admonitions_ds2ad {
  local f="$1"

python3 -c "
import re
import sys

ad_type_map = {
    'note': 'NOTE',
    'tip': 'TIP',
    'info': 'IMPORTANT',
    'warning': 'CAUTION',
    'caution': 'CAUTION',
    'danger': 'WARNING'
}


def admonition_ds2ad(adt):
    # Convert admonitions from Docusaurus to Asciidoctor
    # Named captures are e(everything), y(type), t(title), b(body)
    p = r'(?P<e>^(\s*):::(?P<y>\w+)(\n|\s|\[)(?P<t>.*?)(?<=\n)(?P<b>.*?)(^(\s*):::))'

    matches = re.finditer(p, adt, re.MULTILINE | re.DOTALL)

    for match in matches:
        ad_type = ad_type_map[match.group('y')]
        ad_title = match.group('t')
        if ad_title != '':
            ad_title = '.' + ad_title
            # Next line is a bit of a bodge as I can't find the regex to
            # both match and exclude the closing ']'
            ad_title = re.sub(r']', '', ad_title)
        ad_body = match.group('b')
        adt = adt.replace(match.group('e'),
                          f'\n[{ad_type}]\n{ad_title}====\n{ad_body}====\n')

    return adt


def main():
    if len(sys.argv) != 2:
        print('Usage: python admon.py input.md')
        sys.exit(1)

    md_file = sys.argv[1]

    with open(md_file, 'r', encoding='utf-8') as f:
        md_in = f.read()
        f.close()

    md_out = admonition_ds2ad(md_in)

    with open(md_file, 'w', encoding='utf-8') as f:
        f.write(md_out)
        f.close()


if __name__ == '__main__':
    main()
" "$f"
}

admonitions_ds2ad "$1"
#Convert DS admonitions to AD admonitions

#!/bin/bash
shopt -s globstar

# pandoc converter - html to asciidoc
rm -rf ./pandoc_html_to_asciidoc && \
mkdir -p ./pandoc_html_to_asciidoc && \
cp -r ./build/* ./pandoc_html_to_asciidoc/

find ./pandoc_html_to_asciidoc -type f -name "*.html" -exec sh -c '
    for file do
        echo "Processing file $file"
        content=$(grep -o "<div class=\"theme-doc-markdown markdown\">.*</div>" "$file")
        echo "$content" > temp.html
        pandoc -f html -t asciidoc temp.html -o "${file%.html}.adoc"        
        rm temp.html
    done
' _ {} +
rm ./pandoc_html_to_asciidoc/**/*.html

# pandoc converter - md to asciidoc
rm -rf ./pandoc_md_to_asciidoc && \
mkdir -p ./pandoc_md_to_asciidoc && \
mkdir -p ./pandoc_md_to_asciidoc/i18n/zh/docusaurus-plugin-content-docs && \
cp -r ./docs ./shared-files ./pandoc_md_to_asciidoc && \
cp -r ./i18n/zh/docusaurus-plugin-content-docs/current ./pandoc_md_to_asciidoc/i18n/zh/docusaurus-plugin-content-docs/current

find ./pandoc_md_to_asciidoc -type f -name "*.md" -exec sh -c 'echo Processing file $1 & pandoc --wrap=none -f gfm -t asciidoc --verbose "$1" -o "${1%.md}.adoc"' _ {} \;
rm ./pandoc_md_to_asciidoc/**/*.md

# kramdown converter - md to asciidoc
rm -rf ./kramdown_md_to_asciidoc && \
mkdir -p ./kramdown_md_to_asciidoc && \
mkdir -p ./kramdown_md_to_asciidoc/i18n/zh/docusaurus-plugin-content-docs && \
cp -r ./docs ./shared-files ./kramdown_md_to_asciidoc && \
cp -r ./i18n/zh/docusaurus-plugin-content-docs/current ./kramdown_md_to_asciidoc/i18n/zh/docusaurus-plugin-content-docs


find ./kramdown_md_to_asciidoc -type f -name "*.md" -exec sh -c 'echo Processing file $1 & kramdoc -o "${1%.md}.adoc" "$1"' _ {} \;
find ./kramdown_md_to_asciidoc -type f -name "*.adoc" -exec sh -c 'echo Replacing Admonitions in file $1 & admon.sh "$1" ' _ {} \;
rm ./kramdown_md_to_asciidoc/**/*.md

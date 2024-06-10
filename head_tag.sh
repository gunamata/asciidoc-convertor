#!/bin/bash
# $1 = FILE
# $2 = TARGET (antora or daps) 
# $3 = DOMAIN (OPTIONAL)
# e.g. sh process_head_tag.sh docs/file.md antora
# e.g. sh process_head_tag.sh docs/file.md daps https://example.com

function process_head_tag {
  local f="$1"
  local a="$2"
  local d="$3"

ruby -e '

for_antora = ARGV[1]=="antora" ? true : false

process_head_tag(ARGV[0], for_antora)

BEGIN {
  # Antora: only removes <head> tag and its contents
  # Other: remove <head> tag and move its contents into a docfile, <file>-docinfo.html
  def process_head_tag(file, for_antora)
    new_file = []
    new_docinfo_file = []
    docinfo_filename = file.sub(/\.md[x]*$/,"-docinfo.html")
    docinfo_enabler = %{:docinfo: private-head
}
    parsing_head_tag = false
    
    File.foreach(file).with_index do |line, line_num|
      if parsing_head_tag
        if line.strip.include?("</head>")
          parsing_head_tag = false
          File.write(docinfo_filename, new_docinfo_file.join) if !for_antora
        elsif !for_antora
          if line.strip.include?("rel=\"canonical\"")
            domain = !ARGV[2].empty? ? ARGV[2].chomp("/") : "NEW_BASEURL"
            new_line = line.sub(/href=\".*\.com/, "href=\""+domain)
            new_docinfo_file << new_line
          else
            new_docinfo_file << line.strip
          end
        end
      else
        if line.strip.include?("<head>")
          new_file << docinfo_enabler if !for_antora
          parsing_head_tag = true
        else
          new_file << line
        end
      end
    end

    File.write(file, new_file.join)
  end
}

' "$f" "$a" "$d"
}


process_head_tag "$1" "$2" "$3"

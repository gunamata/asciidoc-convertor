FROM ruby:3.1.5-slim-bullseye

# Install pandoc
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y pandoc && \
    apt-get install -y python3 python3-pip && \
    apt-get -y autoclean

# Install Kramdown AsciiDoc
RUN gem install kramdown-asciidoc

# Copy the script into the container
COPY convert.sh admon.sh collapsible_block.sh /usr/local/bin/

# Set the script as executable
RUN chmod +x /usr/local/bin/convert.sh \
             /usr/local/bin/admon.sh \
             /usr/local/bin/collapsible_block.sh

# Set the working directory
WORKDIR /workspace

# Default command to run the script
CMD ["convert.sh", "/workspace"]

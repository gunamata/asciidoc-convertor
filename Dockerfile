FROM ruby:3.1.5-slim-bullseye

# Install pandoc
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y pandoc && \
    apt-get -y autoclean

# Install Kramdown AsciiDoc
RUN gem install kramdown-asciidoc

# Copy the script into the container
COPY convert.sh /usr/local/bin/convert.sh

# Set the script as executable
RUN chmod +x /usr/local/bin/convert.sh

# Set the working directory
WORKDIR /workspace

# Default command to run the script
CMD ["convert.sh", "/workspace"]

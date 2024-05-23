# ASCIIDOC-CONVERTOR

A simple tool to convert docs content in a Docusaurus project to asciidoc format.

## How to run?

Easiest way to run is via docker. Here are the commands.

**Windows CMD:**

```
docker run -v %cd%:/workspace/ matamagu/asciidoc-converter:latest
```

**Linux, macOS:**

```
docker run -v $(pwd):/workspace/ matamagu/asciidoc-converter:latest
```

## How to build the docker image

If you modify the script then you can rebuild the contianer image using the command:

```
docker build -t matamagu/asciidoc-converter:latest .
```

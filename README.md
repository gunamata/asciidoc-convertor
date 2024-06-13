# ASCIIDOC-CONVERTOR

A simple script to convert docs content in a Docusaurus project to asciidoc format using the tools [pandoc](https://pandoc.org/index.html) and [kramdown-asciidoc](https://github.com/asciidoctor/kramdown-asciidoc)

## How to run?

Easiest way to run is via docker. Run the docker command below from the root of a docusaurus project. At the end of the run, you should see new folders created with the asciidoc files.

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

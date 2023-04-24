# Nim Pandoc

> Pandoc AST Type Definitions for Nim Language

## Pandoc

> Pandoc is a Haskell library for converting from one markup format to another, and a command-line
> tool that uses this library.
>
> Pandoc can convert between numerous markup and word processing formats, including, but not limited to,
> various flavors of Markdown, HTML, LaTeX and Word docx. For the full lists of input and output formats,
> see the --from and --to options below. Pandoc can also produce PDF output: see creating a PDF, below.
>
> ref: [https://pandoc.org/MANUAL.html](https://pandoc.org/MANUAL.html#)

## Pandoc Data Structure

Pandoc holds data of the document within the memory to parse the document and understand the structure.
The structure definition is in [Text.Pandoc.Definition](https://hackage.haskell.org/package/pandoc-types-1.23/docs/Text-Pandoc-Definition.html),
where the latest version is `1.23`.

This structure is exportable to `json` format, which is readable by a lot of programming languages.

This package aims to parse the `json` file produced by pandoc and understand the context with the `nim` language.

All data types are predefined in this package and is parsable from / to `json` format.

## Getting Started

Pandoc is able to generate `json` file from a lot of languages and formats.

Here, I will take `markdown` file ([`./tests/norg_tutorial.md`](./tests/norg_tutorial.md)) as an example.

```bash
# Construct json file from markdown
$ pandoc -f markdown ./tests/norg_tutorial.md -t json -o parsed.json
```

### Load `json` in `nim` File

```nim
import std/json
import std/jsonutils

import nim_pandoc

when isMainModule:
  # Read file content as string
  var jsonContent = readFile("./parsed.json")

  # Parse json
  var jobj = parseJson(jsonContent)
  # Convert json to `seq[PDBlock]` type.
  # This is the default type of the top structure of the whole document.
  var blocks = jsonTo(jobj["blocks"], seq[PDBlock])
  echo "jsonTo done"

  # Convert structure back to json and print
  echo toJson(blocks)
```

## Documentation

**WIP**

## Tests

**WIP**

## Future Works

- [ ] [`Meta`](https://hackage.haskell.org/package/pandoc-types-1.23/docs/Text-Pandoc-Definition.html#t:Meta) is not implemented yet.
  - Cannot load the metadata of document.

## # Nim Type Definitions of Pandoc AST
import std/json
import std/jsonutils
import std/options

include nim_pandoc/pd_include_h
include nim_pandoc/pandoc_macro

proc toJsonHook*(self: PDBlock): JsonNode
proc fromJsonHook*(self: var PDBlock, o: JsonNode, opt = Joptions())
proc `$`*(self: PDBlock): string

proc toJsonHook*(self: PDInline): JsonNode
proc fromJsonHook*(self: var PDInline, o: JsonNode, opt = Joptions())
proc `$`*(self: PDInline): string

proc toJsonHook*(self: PDColWidth): JsonNode =
  if self.c.isSome():
    result = %* {"t": self.t, "c": self.c.get()}
  else:
    result = %* {"t": self.t}

proc fromJsonHook*(self: var PDColWidth, o: JsonNode, opt = Joptions()) =
  self.t = o{"t"}.getStr()
  if o.contains("c"):
    self.c = some(o{"c"}.getInt())

proc fromJsonHook*(self: var PDCaption, o: JsonNode, opt = Joptions()) =
  var elems = o.getElems()
  if elems[0].kind == JNull:
    self = (none(PDShortCaption), jsonTo(elems[1], seq[PDBlock]))
  else:
    self = (some(jsonTo(elems[0], PDShortCaption)), jsonTo(elems[1], seq[PDBlock]))

proc toJsonHook*(self: PDInlineBase0): JsonNode =
  result = %* {"t": self.t}

proc fromJsonHook*(self: var PDInlineBase0, o: JsonNode, opt = Joptions()) =
  self = new PDInlineBase0
  self.t = o{"t"}.getStr()

proc toJsonHook*(self: PDInlineBase): JsonNode =
  result = %* {
    "t": self.t,
    "c": self.c,
  }

proc fromJsonHook*[T](self: var PDInlineBase[T], o: JsonNode, opt = Joptions()) =
  self = new PDInlineBase
  self.t = o{"t"}.getStr()
  self.c = jsonTo(o{"c"}, T)

refObjectJsonHook PDInline:
  ["Space", "SoftBreak", "LineBreak"]: PDInlineBase0
  ["Str"]: PDInlineBase[string]
  ["Emph", "Underline", "Strong", "Strikeout", "Superscript", "Subscript", "SmallCaps"]:
    PDInlineBase[seq[PDInline]]
  ["Note"]: PDInlineBase[seq[PDBlock]]
  ["Quoted"]: PDInlineBase[(PDQuoteType, seq[PDInline])]
  ["Cite"]: PDInlineBase[(seq[PDCitation], seq[PDInline])]
  ["Code"]: PDInlineBase[(PDAttr, string)]
  ["Math"]: PDInlineBase[(PDMathType, string)]
  ["RawInline"]: PDInlineBase[(PDFormat, string)]
  ["Span"]: PDInlineBase[(PDAttr, seq[PDInline])]
  ["Link", "Image"]: PDInlineBase[(PDAttr, seq[PDInline], PDTarget)]

func toJsonHook*(self: PDBlockBase0): JsonNode =
  result = %* {"t": self.t}

func fromJsonHook*(self: var PDBlockBase0, o: JsonNode, opt = Joptions()) =
  self = new PDBlockBase0
  self.t = o{"t"}.getStr()

func toJsonHook*(self: PDBlockBase): JsonNode =
  result = %* {
    "t": self.t,
    "c": self.c,
  }

func fromJsonHook*[T](self: var PDBlockBase[T], o: JsonNode, opt = Joptions()) =
  self = new PDBlockBase
  self.t = o{"t"}.getStr()
  self.c = jsonTo(o{"c"}, T)

refObjectJsonHook PDBlock:
  ["HorizontalRule"]: PDBlockBase0
  ["Plain", "Para"]: PDBlockBase[seq[PDInline]]
  ["LineBlock"]: PDBlockBase[seq[seq[PDInline]]]
  ["BlockQuote"]: PDBlockBase[seq[PDBlock]]
  ["BulletList"]: PDBlockBase[seq[seq[PDBlock]]]
  ["DefinitionList"]: PDBlockBase[seq[(seq[PDInline], seq[seq[PDBlock]])]]
  ["CodeBlock"]: PDBlockBase[(PDAttr, string)]
  ["RawBlock"]: PDBlockBase[(PDFormat, string)]
  ["OrderedList"]: PDBlockBase[(PDListAttributes, seq[seq[PDBlock]])]
  ["Div"]: PDBlockBase[(PDAttr, seq[PDBlock])]
  ["Header"]: PDBlockBase[(int, PDAttr, seq[PDInline])]
  ["Figure"]: PDBlockBase[(PDAttr, PDCaption, seq[PDBlock])]
  ["Table"]: PDBlockBase[(PDAttr, PDCaption, seq[PDColSpec], PDTableHead, seq[PDTableBody], PDTableFoot)]

when isMainModule:
  var jsonContent = readFile("./tests/norg_tutorial.json")
  echo "len: ", jsonContent.len()

  var jobj = parseJson(jsonContent)
  var blocks = jsonTo(jobj["blocks"], seq[PDBlock])
  echo "jsonTo done"
  echo blocks

  echo toJson(blocks)

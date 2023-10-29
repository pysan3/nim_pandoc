import std/jsonutils
import std/json
import strformat
import options

import pandoc_macro
import pd_block_h
import pd_inline_h
import pd_attr_h
import pd_caption_h
import pd_format_h
import pd_table_h
import pd_list_h
import pd_citation_h
import pd_inline

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

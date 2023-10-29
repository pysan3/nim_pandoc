import std/jsonutils
import std/json
import strformat
import options

import pandoc_macro
import pd_inline_h
import pd_attr_h
import pd_target_h
# import pd_block_h
import pd_types_h
import pd_citation_h
import pd_format_h

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
  # ["Note"]: PDInlineBase[seq[PDBlock]]
  ["Quoted"]: PDInlineBase[(PDQuoteType, seq[PDInline])]
  ["Cite"]: PDInlineBase[(seq[PDCitation], seq[PDInline])]
  ["Code"]: PDInlineBase[(PDAttr, string)]
  ["Math"]: PDInlineBase[(PDMathType, string)]
  ["RawInline"]: PDInlineBase[(PDFormat, string)]
  ["Span"]: PDInlineBase[(PDAttr, seq[PDInline])]
  ["Link", "Image"]: PDInlineBase[(PDAttr, seq[PDInline], PDTarget)]

import std/options
import std/jsonutils
import std/json

import pd_attr_h
import pd_block_h

type
  PDRowHeadColumns* = int
  PDAlignment* = object
    t*: string
  PDColWidth* = object
    t*: string
    c*: Option[int]
  PDRowSpan* = int
  PDColSpan* = int
  PDCell* = (PDAttr, PDAlignment, PDRowSpan, PDColSpan, seq[PDBlock])
  PDColSpec* = (PDAlignment, PDColWidth)
  PDRow* = (PDAttr, seq[PDCell])
  PDTableHead* = (PDAttr, seq[PDRow])
  PDTableBody* = (PDAttr, PDRowHeadColumns, seq[PDRow], seq[PDRow])
  PDTableFoot* = (PDAttr, seq[PDRow])

proc toJsonHook*(self: PDColWidth): JsonNode =
  if self.c.isSome():
    result = %* {"t": self.t, "c": self.c.get()}
  else:
    result = %* {"t": self.t}

proc fromJsonHook*(self: var PDColWidth, o: JsonNode, opt = Joptions()) =
  self.t = o{"t"}.getStr()
  if o.contains("c"):
    self.c = some(o{"c"}.getInt())

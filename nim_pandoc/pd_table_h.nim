import options

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
  PDCell* = object
    t*: string
    c*: (PDAttr, PDAlignment, PDRowSpan, PDColSpan, seq[PDBlock])
  PDColSpec* = (PDAlignment, PDColWidth)
  PDRow* = object
    t*: string
    c*: (PDAttr, seq[PDCell])
  PDTableHead* = object
    t*: string
    c*: (PDAttr, seq[PDRow])
  PDTableBody* = object
    t*: string
    c*: (PDAttr, PDRowHeadColumns, seq[PDRow], seq[PDRow])
  PDTableFoot* = object
    t*: string
    c*: (PDAttr, seq[PDRow])

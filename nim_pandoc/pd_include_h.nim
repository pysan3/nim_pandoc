import std/options

include nim_pandoc/pd_attr_h
include nim_pandoc/pd_inline_h
include nim_pandoc/pd_format_h
include nim_pandoc/pd_list_h
include nim_pandoc/pd_target_h
include nim_pandoc/pd_types_h
include nim_pandoc/pd_block_h
# include nim_pandoc/pd_citation_h # inline
# include nim_pandoc/pd_table_h # attr, block
# include nim_pandoc/pd_caption_h # inline, block

type
  PDCitationMode* = object
    t*: string
  PDCitation* = object
    citationId*: string
    citationPrefix*: seq[PDInline]
    citationSuffix*: seq[PDInline]
    citationMode*: PDCitationMode
    citationNoteNum*: int
    citationHash*: int

type
  PDShortCaption* = seq[PDInline]
  PDCaption* = (Option[PDShortCaption], seq[PDBlock])

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

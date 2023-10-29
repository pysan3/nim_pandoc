import pd_inline_h

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

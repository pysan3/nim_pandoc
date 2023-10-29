## # Nim Type Definitions of Pandoc AST
import std/json
import std/jsonutils

include nim_pandoc/pd_attr_h
include nim_pandoc/pd_inline_h
include nim_pandoc/pd_caption_h
include nim_pandoc/pd_citation_h
include nim_pandoc/pd_format_h
include nim_pandoc/pd_list_h
include nim_pandoc/pd_table_h
include nim_pandoc/pd_target_h
include nim_pandoc/pd_types_h
include nim_pandoc/pd_inline
include nim_pandoc/pd_caption
include nim_pandoc/pd_block_h
include nim_pandoc/pd_block

proc add*(x, y: int): int =
  return x + y

when isMainModule:
  var jsonContent = readFile("./tests/norg_tutorial.json")
  # echo jsonContent
  echo "len: ", jsonContent.len()

  # var jobj = parseJson("""{"t":"Header","c":[1, ["", [], []], [{"t":"Str","c":"hoge"}]]}""")
  # var blocks = jsonTo(jobj, PDBlock)

  # var jobj = parseJson("""{"t":"Code","c":[["", [], []], "code here"]}""")
  # var blocks = jsonTo(jobj, PDInline)

  # var content =
  #   """
  #       {
  #         "t": "Cite",
  #         "c": [
  #           [
  #             {
  #               "citationId": "mnih2015human",
  #               "citationPrefix": [],
  #               "citationSuffix": [],
  #               "citationMode": {
  #                 "t": "NormalCitation"
  #               },
  #               "citationNoteNum": 0,
  #               "citationHash": 0
  #             }
  #           ],
  #           [
  #             {
  #               "t": "RawInline",
  #               "c": [
  #                 "latex",
  #                 "\\cite{mnih2015human}"
  #               ]
  #             }
  #           ]
  #         ]
  #       }
  #   """
  # var jobj = parseJson(content)
  # var blocks = jsonTo(jobj, PDInline)

  # var content =
  #   """
  #     {
  #       "t": "Header",
  #       "c": [
  #         1,
  #         [
  #           "",
  #           [],
  #           []
  #         ],
  #         [
  #           {
  #             "t": "Str",
  #             "c": "Works"
  #           }
  #         ]
  #       ]
  #     }
  #   """
  # var jobj = parseJson(content)
  # var blocks = jsonTo(jobj, PDBlock)

  var jobj = parseJson(jsonContent)
  var blocks = jsonTo(jobj["blocks"], seq[PDBlock])
  echo "jsonTo done"
  echo blocks

  echo toJson(blocks)

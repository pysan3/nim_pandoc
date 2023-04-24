type
  PDTarget* = (string, string)

func url*(self: PDTarget): string =
  self[0]

func title*(self: PDTarget): string =
  self[1]

Object = require("lib/classic")

Library = Object:extend()

function Library:init()
  self.books = {}
  -- self.books['test'] = 'blahhhh'

  return self

end

function Library:load()
  local files = lovr.filesystem.getDirectoryItems('assets/books/room/')
  local roomText = ""
  for i, file in ipairs(files) do
    roomText = roomText .. lovr.filesystem.read('assets/books/room/' .. file)
  end

  room = {
    book = Book:init("A Room of One's Own", "Virginia Woolf", roomText),
    model = lovr.graphics.newModel('assets/models/book.obj', 'assets/textures/texture.jpg'),
    position = lovr.math.newTransform(-1, 0.38, 0.4, 0.3, 0.3, 0.3, math.rad(180), 1, 1, 0)
  }
  -- self.books['Room'] = room
  table.insert(self.books, room)

  -- prince = {
  --   book = Book:init("The Prince", "Nicolo Machiavelli", Library:getText('assets/books/unzipped/Prince')),
  --   model = lovr.graphics.newModel('assets/models/book.obj', 'assets/textures/texture.jpg'),
  --   position = lovr.math.newTransform(1, 0.2, 0, 0.3, 0.3, 0.3)
  -- }
  -- -- self.books['Prince'] = prince
  -- table.insert(self.books, prince)
  --
  -- emma = {
  --   book = Book:init("Emma", "Jane Austen", Library:getText('assets/books/unzipped/Emma')),
  --   model = lovr.graphics.newModel('assets/models/book.obj', 'assets/textures/texture.jpg'),
  --   position = lovr.math.newTransform(0, 0.2, 0, 0.3, 0.3, 0.3)
  -- }
  -- -- self.books['Emma'] = emma
  -- table.insert(self.books, emma)

end

-- load files
function Library:getText(dir)
  local files = lovr.filesystem.getDirectoryItems(dir)
  local text = ""

  -- iterate over HTML files from unzipped epub
  for i, file in ipairs(files) do
   local extract = Library:parseHTML(dir .. '/' .. file)
   text = text .. extract
  end
  return text

end

-- extract text
function Library:parseHTML(file)
  local htmlparser = require('lib/htmlparser/init')

  local rawText = lovr.filesystem.read(file)
  local html = htmlparser.parse(rawText)

  -- select all paragraphs except for Table of Contents
  local elements = html:select("p:not(.toc)")

  local text = ""
  for _, e in ipairs(elements) do
    -- extract p-tag content
    text = text .. "\n\n" .. e:getcontent()
  end

  -- strip HTML word styling
  text = string.gsub(text, "<(.)>", "")
  text = string.gsub(text, "<(.+)/>", "")
  text = string.gsub(text, "</(.)>", "")

  -- print("parseHTML returned text", string.sub(text, 1, 500))
  return text

end

-- places all books in environment
function Library:draw()
  -- local x = 0
  -- local y = 0
  -- local z = 0

  for i, book in ipairs(self.books) do
    book['model']:draw(book['position'])
  end

end

-- checks if a book is active or not
function Library:setActiveBook()


end

return Library

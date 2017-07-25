Object = require("lib/classic")

Library = Object:extend()

function Library:new()
  self.books = {}

end

function Library:load()
  local files = lovr.filesystem.getDirectoryItems('assets/books/room/')
  local roomText = ""
  for i, file in ipairs(files) do
    roomText = roomText .. lovr.filesystem.read('assets/books/room/' .. file)
  end

  room = {
    book = Book("A Room of One's Own", "Virginia Woolf", roomText),
    model = lovr.graphics.newModel('assets/models/book.obj', 'assets/textures/texture.jpg'),
    position = lovr.math.newTransform(-0.9, 0.38, 0.4, SCALE, SCALE, SCALE, math.rad(90), 0, 0, 1)
  }
  self.books['Room'] = room

  prince = {
    book = Book("The Prince", "Nicolo Machiavelli", Library:getText('assets/books/unzipped/ThePrince')),
    model = lovr.graphics.newModel('assets/models/book.obj', 'assets/textures/texture.jpg'),
    position = lovr.math.newTransform(0.9, 0.89, -1, SCALE, SCALE, SCALE, math.rad(90), 0, 0, 1)
  }
  self.books['Prince'] = prince

  emma = {
    book = Book("Emma", "Jane Austen", Library:getText('assets/books/unzipped/Emma')),
    model = lovr.graphics.newModel('assets/models/book.obj', 'assets/textures/texture.jpg'),
    position = lovr.math.newTransform(0.2, 0.76, -1.4, SCALE, SCALE, SCALE, math.rad(90), 0, 0, 1)
  }
  self.books['Emma'] = emma

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
  for i, book in pairs(self.books) do
    book['model']:draw(book['position'])
  end

end

-- checks if a book is active or not
function Library:setActiveBook()


end

return Library

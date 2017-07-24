Object = require("lib/classic")

Library = Object:extend()

function Library:init()
  self.books = {}
  self.books['test'] = 'blahhhh'

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
    position = { 0, 0, 0, 0.4 }
  }
  -- self.books['Room'] = room
  table.insert(self.books, room)

  prince = {
    -- book = Book:init("The Prince", "Nicolo Machiavelli", Library:getText('assets/books/unzipped/ThePrince')),
    book = Book:init("The Prince", "Nicolo Machiavelli", "PRINCE TEST TEST TEST TEST"),
    model = lovr.graphics.newModel('assets/models/book.obj', 'assets/textures/texture.jpg'),
    position = { 2, 2, 2, 0.4 }
  }
  -- self.books['Prince'] = prince
  table.insert(self.books, prince)

  emma = {
    book = Book:init("Emma", "Jane Austen", Library:getText('assets/books/unzipped/Emma')),
    -- book = Book:init("Emma", "Jane Austen", "EMMA TEST TEST TEST TEST"),
    model = lovr.graphics.newModel('assets/models/book.obj', 'assets/textures/texture.jpg'),
    position = { 1, 1, 1, 0.4 }
  }
  -- self.books['Emma'] = emma
  table.insert(self.books, emma)

end

-- load files
function Library:getText(dir)
  local files = lovr.filesystem.getDirectoryItems(dir)
  local text = ""

  -- iterate over HTML files from unzipped epub
  for i, file in ipairs(files) do
  --  local html = lovr.filesystem.read(dir .. '/' .. file)
  --  print('html', html)
   local extract = Library:parseHTML(dir .. '/' .. file)
   text = text .. extract
  end
  return text

end

-- extract text
function Library:parseHTML(file)
  local htmlparser = require('lib/htmlparser/init')

  -- local currentFile = io.input('assets/books/unzipped/Emma/@public@vhost@g@gutenberg@html@files@158@158-h@158-h-0.htm.html')
  -- local rawText = io.read("*a") currentFile:close()
  local rawText = lovr.filesystem.read(file)
  local html = htmlparser.parse(rawText)

  -- select all paragraphs except for Table of Contents
  local elements = html:select("p:not(.toc)")

  local text = ""
  for _, e in ipairs(elements) do
    -- extract p-tag content
    text = text .. "\n" .. e:getcontent()
  end

  -- strip HTML word styling
  text = string.gsub(text, "<(.)>", "")
  text = string.gsub(text, "<(.+)/>", "")
  text = string.gsub(text, "</(.)>", "")

  print("parseHTML returned text", string.sub(text, 1, 500))
  return text

end

-- places all books in environment
function Library:draw()
  local x = 0
  local y = 0
  local z = 0

  for i, book in ipairs(self.books) do
    book['model']:draw(x, y, z, 0.4)
    x = x + 0.5
    y = y + 0.5
    z = z + 0.5
  end

end

-- checks if a book is active or not
function Library:setActiveBook()


end

return Library

Library = {}

function Library:init()
  self.books = {}

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

  emma = {
    -- book = Book:init("Emma", "Jane Austen", Library:getText('assets/books/unzipped/Emma')),
    book = Book:init("Emma", "Jane Austen", "EMMA TEST TEST TEST TEST"),
    model = lovr.graphics.newModel('assets/models/book.obj', 'assets/textures/texture.jpg'),
    position = { 1, 1, 1, 0.4 }
  }
  -- self.books['Emma'] = emma
  table.insert(self.books, emma)

  prince = {
    -- book = Book:init("The Prince", "Nicolo Machiavelli", Library:getText('assets/books/unzipped/ThePrince')),
    book = Book:init("The Prince", "Nicolo Machiavelli", "PRINCE TEST TEST TEST TEST"),
    model = lovr.graphics.newModel('assets/models/book.obj', 'assets/textures/texture.jpg'),
    position = { 2, 2, 2, 0.4 }
  }
  -- self.books['Prince'] = prince
  table.insert(self.books, prince)

end

-- load files
function Library:getText(dir)
  local files = lovr.filesystem.getDirectoryItems(dir)
  local text = ""

  -- iterate over HTML files from unzipped epub
  for i, file in ipairs(files) do
   local html = lovr.filesystem.read('assets/books/room/' .. file)
   local extract = Library:parseHTML(html)
   text = text .. extract
  end
  return text

end

-- extract text
function Library:parseHTML(file)
  local htmlparser = require('lib/htmlparser/init')

end

-- places all books in environment
function Library:draw()
  local x = 0
  local y = 0
  local z = 0

  for i, book in ipairs(self.books) do
    book['model']:draw(x, y, z, 0.4)
    x = x + 1
    y = y + 1
    z = z + 1
  end

end

-- checks if a book is active or not
function Library:setActiveBook()


end

return Library

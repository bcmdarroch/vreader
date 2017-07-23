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
    model = lovr.graphics.newModel('assets/book.obj', 'assets/texture.jpg'),
    position = { 0, 0, 0 }
  }
  self.books['Room'] = room

  -- emma = {
  --   book = Book:init("Emma", "Jane Austen", Library:getText('assets/books/unzipped/Emma')),
  --   model = ,
  --   position = { 1, 1, 1 }
  -- }
  -- self.books['Emma'] = emma

  -- prince = {
  --   book = Book:init("The Prince", "Nicolo Machiavelli", Library:getText('assets/books/unzipped/ThePrince')),
  --   model = ,
  --   position = { 2, 2, 2 }
  -- }
  -- self.books['Prince'] = prince

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

end

-- checks if a book is active or not
function Library:setActiveBook()


end

return Library

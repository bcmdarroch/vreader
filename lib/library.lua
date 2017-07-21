Library = {}

function Library:init()
  self.books = {}

  bookText = lovr.filesystem.read('assets/books/room/part1.txt') .. lovr.filesystem.read('assets/books/room/part2.txt') .. lovr.filesystem.read('assets/books/room/part3.txt') .. lovr.filesystem.read('assets/books/room/part4.txt') .. lovr.filesystem.read('assets/books/room/part5.txt') .. lovr.filesystem.read('assets/books/room/part6.txt')
  room = {}
  room['book'] = Book:init("A Room of One's Own", "Virginia Woolf", bookText)
--   room is table {
--   book = Book:init("A Room of One's Own", "Virginia Woolf", bookText)
--   model = model w texture,
--   position = of model within environment
-- }

  self.books["Room"] = room

  -- load all books from assets/books
  -- emma =
  -- insert
  -- prince
  -- insert ...

  return self

end

-- library:load
  -- load book models for each book


-- library:draw
  -- places all non-active books in environment

-- checks if a book is active or not

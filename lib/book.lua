-- create book class
Book = {}

function Book:new(title, author, text)
  self.__index = self
  self.title = title
  self.author = author
  self.text = parseTxt(text)
  return self
end

function Book:setTitle(newTitle)
  self.title = newTitle
end

function Book:setAuthor(newAuthor)
  self.author = newAuthor
end

function Book:parseTxt(text)
  -- parse text by new lines
  -- parse new lines by word, save them to pages in table (index = page num)

  -- or divide text into pages based on max characters per line, only 10 lines per page
end


-- book load

-- book update

-- book draw

-- prints section of text
function lovr.printText(fullText, start, numWords)
  -- first implementation
  -- split text by word into table
  local words = {}
  for word in fullText:gmatch("%S+") do
    -- count new lines!
    table.insert(words, word)
  end

  -- adjust finish variable if needed
  local finish = start + numWords
  if finish > tableLength(words) then
    finish = tableLength(words)
  end

  -- return section of text
  return table.concat(words, " ", start, finish)

end

-- create book class
Book = {}

function Book:new(title, author, text)
  -- self.__index = self
  -- self.title = title
  -- self.author = author
  -- self.text = text
  -- self.text = parseTxt(text)
  -- return self
end

-- book load
function Book:load()
end

-- book update
function Book:update()
end

-- book draw
function Book:draw(mode, x, y, z, planeSize, nx, ny, nz, textScale, textAngle, ax, ay, az)
  lovr.graphics.plane(mode, x, y, z, planeSize, nx, ny, nz)
  lovr.graphics.print(self.text, BX, BY, BZ, textScale, textAngle, ax, ay, az, 10, left, top)
end

function Book:parseTxt(text)
  -- first implementation: split text by word into table
  -- local words = {}
  -- for word in fullText:gmatch("%S+") do
  --   -- count new lines!
  --   table.insert(words, word)
  -- end
  --
  -- -- adjust finish variable if needed
  -- local finish = start + numWords
  -- if finish > tableLength(words) then
  --   finish = tableLength(words)
  -- end
  --
  -- -- return section of text
  -- return table.concat(words, " ")


  -- second implementation: parse text by new lines
  -- parse new lines by word, save them to pages in table (index = page num)


  -- third implementation: divide text into pages based on max characters per line, only 10 lines per page
  -- split by characters
  text = {}
  local start = 1
  local numChars = 50
  local i = 0
  for char in fullText:gmatch(".") do
    i = i + 1

    if i == numChars then -- need to change this conditional so it keeps going til end of text
      local next = string.sub(fullText, i + 1, i + 1)

      -- 1. end of word
      -- 2. in btwn words
      if char == " " or next == " " then
        -- old: return string.sub(fullText, start, start + i)

        -- add string.sub(text, start, i) to text table
        -- i = i + numChars

      -- 3. inside word
      elseif char ~= " " and next ~= " " then
        local prev = ""
        repeat
          i = i - 1
          prev = string.sub(fullText, i - 1, i - 1)
        until prev == " "
        -- old: return string.sub(fullText, start, start + i - 2)

        -- add string.sub(text, start, i) to text table
        -- i = i + numChars
      end
    end
  end

  -- return text table
end


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

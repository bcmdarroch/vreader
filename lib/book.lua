-- create book class
Book = {}

function Book:init(title, author, text)
  self.title = title
  self.author = author
  self.text = Book:parseTxt(text)
  return self

end

-- book update
function Book:update()


end

-- book draw
function Book:draw(mode, x, y, z, planeSize, nx, ny, nz, textScale, textAngle, ax, ay, az)
  lovr.graphics.plane(mode, x, y, z, planeSize, nx, ny, nz)

  -- lovr.graphics.setShader(font) -- setShader/setFont doesn't work
  -- font:setPixelDensity(50)
  -- lovr.graphics.setColor(0, 0, 0, 255)
  lovr.graphics.print(self.text[1], x, y, z, textScale, textAngle, ax, ay, az, 10, left, top)

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
  textTable = { "testing"
  }

  local i = 0
  local numChars = 50
  for char in text:gmatch(".") do
    i = i + 1

    if i == numChars then -- need to change this conditional so it keeps going til end of text
      local next = string.sub(text, i + 1, i + 1)

      -- 1. end of word
      -- 2. in btwn words
      if char == " " or next == " " then
        -- old: return string.sub(text, start, start + i)

        -- add string.sub(text, start, i) to text table
        -- i = i + numChars

      -- 3. inside word
      elseif char ~= " " and next ~= " " then
        local prev = ""
        repeat
          i = i - 1
          prev = string.sub(text, i - 1, i - 1)
        until prev == " "
        -- old: return string.sub(text, start, start + i - 2)

        -- add string.sub(text, start, i) to text table
        -- i = i + numChars
      end
    end
  end

  return textTable

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

return Book

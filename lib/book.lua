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
function Book:draw(p, mode, x, y, z, planeSize, nx, ny, nz, textScale, textAngle, ax, ay, az)
  lovr.graphics.plane(mode, x, y, z, planeSize, nx, ny, nz)

  -- lovr.graphics.setShader(font) -- setShader/setFont doesn't work
  -- font:setPixelDensity(50)
  -- lovr.graphics.setColor(0, 0, 0, 255)
  lovr.graphics.print(self.text[p], x, y, z, textScale, textAngle, ax, ay, az, 10, left, top)
  lovr.graphics.print(p, x + 0.45, y - 0.45, z, textScale - 0.02, textAngle, ax, ay, az, 10, left, top)

end

function Book:parseTxt(text)
  textTable = {}

  local i = 1
  local j = 500

  while j <= string.len(text) do

    local char = string.sub(text, j, j)
    local next = string.sub(text, j + 1, j + 1)

    -- 1. end of word
    -- 2. in btwn words
    if char == " " or next == " " then
      table.insert(textTable, string.sub(text, i, j))

    -- 3. inside word
    elseif char ~= " " and next ~= " " then
      local prev = ""
      repeat
        j = j - 1
        prev = string.sub(text, j - 1, j - 1)
      until prev == " "
      j = j - 1
      table.insert(textTable, string.sub(text, i, j))
    end

    i = j
    j = i + 500
  end

  return textTable

end

return Book

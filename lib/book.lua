-- create book class
Book = {}

function Book:init(title, author, text)
  self.title = title
  self.author = author
  self.text = Book:parseTxt(text)
  self.inverse = false
  return self

end

-- book update
function Book:update()
  for i, controller in ipairs(controllers) do
    -- if trigger down and controller within book plane
    if controller:getAxis('trigger') == 1 and lovr.controllerPlaneCollide(controller) == true then
      -- change book position
      BX, BY, BZ = controller:getPosition()

      -- first implementation:
      -- translate rotation (keep forward vector of fixed toward headset)
      angle, BAX, BAY, BAZ = controller:getOrientation()


      -- second implementation (to draw):
      --  rotateMode = true
    end
  end

end

-- book draw
function Book:draw(p, mode, x, y, z, planeSize, textScale, angle, ax, ay, az)
  -- render plane
  if self.inverse then
    lovr.graphics.setColor(255, 255, 255)
  else
    lovr.graphics.setColor(0, 0, 0)
  end
  lovr.graphics.plane(mode, x, y, z, planeSize, angle, ax, ay, az)

  -- render text
  if self.inverse then
    lovr.graphics.setColor(0, 0, 0)
  else
    lovr.graphics.setColor(255, 255, 255)
  end
  -- lovr.graphics.setShader(font) -- setShader/setFont doesn't work
  -- font:setPixelDensity(50)

  -- line by line:
  -- local displayText = ""
  -- for i = p, p + 9 do
  --   displayText = displayText .. self.text[i]
  -- end
  -- displayText is self.text[p]
  lovr.graphics.print(self.text[p], x, y - 0.02, z + 0.001, textScale, angle, ax, ay, az, 12, left, top)
  lovr.graphics.print(p, x + 0.45, y - 0.45, z + 0.001, textScale - 0.02, angle, ax, ay, az, 10, left, top)
  lovr.graphics.print(self.title, x, y + 0.45, z + 0.001, textScale - 0.02, angle, ax, ay, az, 10, left, top)

  -- undo global color change
  lovr.graphics.setColor(255, 255, 255)
end

function Book:parseTxt(text)
  textTable = {}
  -- by page
  local i = 1
  local j = 500

  -- by line
  -- local j = 50

  while j <= string.len(text) do

    local char = string.sub(text, j, j)
    local next = string.sub(text, j + 1, j + 1)

    -- check if ends at end of word, in btwn words
    if char == " " or next == " " then
      table.insert(textTable, string.sub(text, i, j))

    -- check if ends inside word
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
    -- j = i + 50
  end
  return textTable

end

function Book:turnPage(controller)
  if controller:getAxis('touchx') > 0 or controller:getAxis('touchy') < 0 then
      PAGE = PAGE + 1
      if PAGE > #book.text then
        PAGE = #book.text
      end
  elseif controller:getAxis('touchx') < 0 and controller:getAxis('touchy') > 0 then
    PAGE = PAGE - 1
    if PAGE < 1 then
      PAGE = 1
    end
  end

end

function Book:inverseColors()
  self.inverse = not self.inverse
end

return Book

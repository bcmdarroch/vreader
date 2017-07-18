-- 1. create book class
Book = {}

function Book:init(title, author, text)
  self.title = title
  self.author = author
  self.text = Book:parseTxt(text)

  self.x = 0
  self.y = 1
  self.z = 0
  self.page = 1
  self.angle = 0
  self.bax = 0
  self.bay = 0
  self.baz = 0
  self.planeSize = 1
  self.textScale = 0.05
  self.inverse = false

  return self

end

-- 2. main LOVR callbacks
function Book:update()


end

-- book draw
function Book:draw()
  local x = self.x
  local y = self.y
  local z = self.z
  local angle = self.angle
  local ax = self.ax
  local ay = self.ay
  local az = self.az

  -- call move function
  Book:move()

  -- render plane
  if self.inverse then
    lovr.graphics.setColor(255, 255, 255)
  else
    lovr.graphics.setColor(0, 0, 0)
  end
  lovr.graphics.plane('fill', x, y, z, self.planeSize, angle, ax, ay, az)

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
  lovr.graphics.print(self.text[self.page], x, y - 0.02, z + 0.001, self.textScale, angle, ax, ay, az, 12, left, top)
  lovr.graphics.print(self.page, x + 0.45, y - 0.45, z + 0.001, self.textScale - 0.02, angle, ax, ay, az, 10, left, top)
  lovr.graphics.print(self.title, x, y + 0.45, z + 0.001, self.textScale - 0.02, angle, ax, ay, az, 10, left, top)

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

-- 3. controller functions
function Book:move()
  for i, controller in ipairs(controllers) do
    if trigger down and controller within book plane
    if controller:getAxis('trigger') == 1 and lovr.controllerPlaneCollide(controller) == true then
      -- change book position
      self.x, self.y, self.z = controller:getPosition()
      self.angle, self.ax, self.ay, self.az = controller:getOrientation()
    end

    -- tracked to headset
    -- if controller:getAxis('trigger') == 1 then
    --   self.x, self.y, self.z = lovr.headset.getPosition()
    --   self.y = self.y + 0.5
    --   self.z = self.z + 1
    --   self.angle = lovr.headset.getOrientation()
    --   _, self.ax, self.ay, self.az = lovr.headset.getOrientation()
    -- end
  end

end

function Book:turnPage(controller)
  if controller:getAxis('touchx') > 0 or controller:getAxis('touchy') < 0 then
      self.page = self.page + 1
      if self.page > #book.text then
        self.page = #book.text
      end
  elseif controller:getAxis('touchx') < 0 and controller:getAxis('touchy') > 0 then
    self.page = self.page - 1
    if self.page < 1 then
      self.page = 1
    end
  end

end

function Book:inverseColors()
  self.inverse = not self.inverse
end

return Book

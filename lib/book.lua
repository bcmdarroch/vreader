-- 1. create book class
Book = {}

function Book:init(title, author, text)
  self.title = title
  self.author = author
  self.text = Book:parseTxt(text)
  self.page = 1
  self.planeSize = 1
  self.textScale = 0.05
  self.inverse = false

  self.x = 0
  self.y = 1
  self.z = 0
  self.angle = 0
  self.ax = 0
  self.ay = 0
  self.az = 0

  return self

end

-- 2. main LOVR callbacks
-- book draw
function Book:draw()
  lovr.graphics.push()

  for i, controller in ipairs(controllers) do
    if controller:getAxis('trigger') == 1 and lovr.controllerPlaneCollide(controller) == true then
    -- if controller:getAxis('trigger') == 1 then
       lovr.graphics.translate(controller:getPosition())
       self.x, self.y, self.z = controller:getPosition()
       lovr.graphics.rotate(controller:getOrientation())
       self.angle, self.ax, self.ay, self.az = controller:getOrientation()
    else
      lovr.graphics.translate(self.x, self.y, self.z)
      lovr.graphics.rotate(self.angle, self.ax, self.ay, self.az)
    end
  end

  -- render plane
  if self.inverse then
    lovr.graphics.setColor(255, 255, 255)
  else
    lovr.graphics.setColor(0, 0, 0)
  end
  lovr.graphics.plane('fill', 0, 0, 0, self.planeSize)

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
  lovr.graphics.print(self.text[self.page], 0, - 0.02, 0.001, self.textScale, 0, 0, 0, 0, 12, left, top)
  lovr.graphics.print(self.page, 0.45, -0.45, 0.001, self.textScale - 0.02, 0, 0, 0, 0, 10, left, top)
  lovr.graphics.print(self.title, 0, 0.45, 0.001, self.textScale - 0.02, 0, 0, 0, 0, 10, left, top)

  -- undo global color/origin changes
  lovr.graphics.setColor(255, 255, 255)
   lovr.graphics.pop()

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

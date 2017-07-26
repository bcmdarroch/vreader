Object = require("lib/classic")

Book = Object:extend()

function Book:new(title, author, text)
  self.title = title
  self.author = author
  self.text = Book:parseText(text)
  self.page = 1
  self.planeSize = 1
  self.textScale = 0.05
  self.inverse = false
  self.active = false

  self.x = 0
  self.y = 1
  self.z = 0
  self.angle = 0
  self.ax = 0
  self.ay = 0
  self.az = 0
  self.scalex = 0.5
  self.scaley = 0.5
  self.scalez = 0.5

end

-- 2. main LOVR callbacks
function Book:draw()
  -- move book position
  for i, controller in ipairs(controllers) do
    if controller:getAxis('trigger') == 1 and lovr.controllerPlaneCollide(controller) == true then
       self.x, self.y, self.z = controller:getPosition()
       self.angle, self.ax, self.ay, self.az = controller:getOrientation()
       self.scalex = 0.75 + controller:getAxis('touchy')
       self.scaley = 0.75 + controller:getAxis('touchy')
       self.scalez = 0.75 + controller:getAxis('touchy')
    end
  end

-- set origin for plane, title, page number
  lovr.graphics.push()
  lovr.graphics.translate(self.x, self.y, self.z)
  lovr.graphics.rotate(self.angle, self.ax, self.ay, self.az)
  lovr.graphics.scale(self.scalex, self.scaley + 0.25, self.scalez)

  -- set plane color
  if self.inverse then
    lovr.graphics.setColor(223, 217, 228)
  else
    lovr.graphics.setColor(38, 38, 38)
  end

  -- render plane
  lovr.graphics.plane('fill', 0, 0, 0, self.planeSize)

  -- set text color
  if self.inverse then
    lovr.graphics.setColor(38, 38, 38)
  else
    lovr.graphics.setColor(223, 217, 228)
  end

  -- render title, page number
  lovr.graphics.print(self.page, 0.45, -0.45, 0.001, self.textScale - 0.01, 0, 0, 0, 0, 10, left, top)
  lovr.graphics.print(self.title, 0, 0.45, 0.001, self.textScale - 0.01, 0, 0, 0, 0, 10, left, top)
  lovr.graphics.pop()

  -- set origin for text
  lovr.graphics.push()
  lovr.graphics.translate(self.x, self.y, self.z)
  lovr.graphics.rotate(self.angle, self.ax, self.ay, self.az)
  lovr.graphics.scale(self.scalex, self.scaley, self.scalez)

  -- render text by page:
  lovr.graphics.print(self.text[self.page], 0, 0, 0.001, self.textScale, 0, 0, 0, 0, 12, left, top)

  -- undo global color/origin changes
  lovr.graphics.setColor(255, 255, 255)
  lovr.graphics.pop()

end

function Book:parseText(text)
  textTable = {}
  if #text < 400 then
    table.insert(textTable, text)
    return textTable
  end

  -- by page
  local i = 1
  local j = 400

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
  end
  return textTable

end

function Book:turnPage(controller)
  if controller:getAxis('touchx') > 0 and controller:getAxis('trigger') < 1 then
      self.page = self.page + 1
      if self.page > #activeBook.text then
        self.page = #activeBook.text
      end
  elseif controller:getAxis('touchx') < 0 and controller:getAxis('trigger') < 1 then
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

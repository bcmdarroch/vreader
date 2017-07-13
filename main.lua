-- LOVR callbacks
function lovr.load()
  require('lib/lua_lib')
  require('lib/lovr_lib')

  -- width, height = lovr.graphics.getDimensions()

  -- load model
  environment =  lovr.graphics.newModel('assets/Room_block_small.obj', 'assets/texture.jpg')

  -- load audio
  sound = lovr.audio.newSource('assets/background.ogg')
  sound:setLooping(true)

  -- load controllers
  refreshControllers()

  -- load book/text
  READMODE = false
  START = 1
  NUMWORDS = 100
  displayText = lovr.filesystem.read('assets/room/part1.txt')
  -- displayText = lovr.filesystem.read('assets/room/part1.txt') .. lovr.filesystem.read('assets/room/part2.txt') .. lovr.filesystem.read('assets/room/part3.txt') .. lovr.filesystem.read('assets/room/part4.txt') .. lovr.filesystem.read('assets/room/part5.txt') .. lovr.filesystem.read('assets/room/part6.txt')
  -- font = lovr.graphics.newFont('assets/Arvo-Regular.ttf', '20')

end


function lovr.update()
  -- test
  -- START = START + NUMWORDS
  -- print(START)
  -- print(NUMWORDS)

  -- has user clicked read mode? (menu button)
  -- for i, controller in ipairs(controllers) do
  --   if controller:isDown('menu') then
  --     READMODE = not READMODE
  --   end
  -- end

  -- has user clicked next page?
  if READMODE then
    -- for i, controller in ipairs(controllers) do
    --   -- clicking touchpad flips page forward
    --   if controller:isDown('touchpad') then
    --     START = START + (NUMWORDS / 10)
    --     if START > string.len(displayText) then
    --       START = string.len(displayText) - NUMWORDS
    --     end
    --   -- clicking trigger flips page backward
    --   elseif controller:getAxis('trigger') == 1 then
    --     START = START - NUMWORDS / 10
    --     if START < 1 then
    --       START = 1
    --     end
    --   end
    end

    -- if controller:getAxis('touchx') == 1 then
    -- elseif controller:getAxis('touchy') == 1 then
  end

end


function lovr.draw()
  -- mac testing:
  -- lovr.graphics.plane('line', 0, 0, -1, 1, 0, 0, 1)
  -- lovr.graphics.print(lovr.printText(displayText, START, NUMWORDS), 0, 0, -1, 0.05, 0, 0, 0, 0, 10, left, top)

  -- play background sound
  sound:play()

  -- render environment given user's position in space
  environment:draw(0, 0, 0, .4)

  -- render UI
  -- for i, controller in pairs(controllers) do
  --   local x, y, z = controller:getPosition()
  --   lovr.graphics.cube('line', x, y, z, 0.1, controller:getOrientation())
  -- end

 --  for i, controller in ipairs(controllers) do
 --   x, y, z = controller:getPosition()
 --   angle, ax, ay, az = controller:getOrientation()
 --   controllerModels[i]:draw(x, y, z, 1, angle, ax, ay, az)
 -- end

  -- if read mode on, render page with in front of camera
  if READMODE then
    lovr.graphics.plane('line', 0, 1, 0, 1, 0, 0, 1)

    -- render text
    -- lovr.graphics.setShader(font) -- setShader/setFont doesn't work
    -- font:setPixelDensity(50)
    -- lovr.graphics.setColor(0, 0, 0, 255)
    lovr.graphics.print(lovr.printText(displayText, START, NUMWORDS), 0, 1, 0, 0.05, 0, 0, 0, 0, 10, left, top)
  end

end

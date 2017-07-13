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
  NUMCHARS = 500
  -- displayText = lovr.filesystem.read('assets/room/part1.txt')
  displayText = lovr.filesystem.read('assets/room/part1.txt') .. lovr.filesystem.read('assets/room/part2.txt') .. lovr.filesystem.read('assets/room/part3.txt') .. lovr.filesystem.read('assets/room/part4.txt') .. lovr.filesystem.read('assets/room/part5.txt') .. lovr.filesystem.read('assets/room/part6.txt')
  -- font = lovr.graphics.newFont('assets/Arvo-Regular.ttf', '20')

end


function lovr.update(dt)
  -- test
  START = START + NUMCHARS * dt * .05
  print(START)
  print(NUMCHARS)

  -- has user clicked read mode? (menu button)
  -- for i, controller in ipairs(controllers) do
  --   if controller:isDown('menu') then
  --     READMODE = not READMODE
  --   end
  -- end

  -- has user clicked next page?
  if READMODE then
    for i, controller in ipairs(controllers) do
      -- clicking touchpad flips page forward
      if controller:isDown('touchpad') then
        START = START + 1 -- should be: go to next line
        -- change alpha of plane to make it fade
        if START > string.len(displayText) then
          START = string.len(displayText) - NUMCHARS
        end
      -- clicking trigger flips page backward
      elseif controller:getAxis('trigger') == 1 then
        START = START - 1 -- should be: go back a line
        if START < 1 then
          START = 1
        end
      end
    end

  -- if controller pressed (touchpad)
      -- if controller:getAxis('touchx') == 1
      print(controller:getAxis('touchx'))
      -- 1, go forward
      -- elseif controller:getAxis('touchx') == 0.51 then
      print(controller:getAxis('touchx'))
  -- end

  -- if controller:getAxis('trigger') == 1 and controller colliding with plane collider (wider than plane)
    -- change origin of plane/text
  -- end


  -- lovr.controllerPlaneCollide
  -- give plane collider, controller sphere
  -- get controller position
  -- get distance btwn plane and controller origins (position - position)
  -- if distance < CONSTANT
    -- return true
  -- else
    -- return false


end


function lovr.draw()
  -- mac testing:
  lovr.graphics.plane('line', 0, 0, -1, 1, 0, 0, 1)
  lovr.graphics.print(lovr.printText(displayText, START, NUMCHARS), 0, 0, -1, 0.05, 0, 0, 0, 0, 15, left, top)

  -- play background sound
  sound:play()

  -- render environment given user's position in space
  -- environment:draw(0, 0, 0, .4)

  -- render UI
  -- for i, controller in ipairs(controllers) do
  --  x, y, z = controller:getPosition()
  --  angle, ax, ay, az = controller:getOrientation()
  --  controllerModels[i]:draw(x, y, z, 1, angle, ax, ay, az)
 end

  -- if read mode on, render page with in front of camera
  if READMODE then
    lovr.graphics.plane('line', 0, 1, 0, 1, 0, 0, 1)

    -- render text
    -- lovr.graphics.setShader(font) -- setShader/setFont doesn't work
    -- font:setPixelDensity(50)
    -- lovr.graphics.setColor(0, 0, 0, 255)
    lovr.graphics.print(lovr.printText(displayText, START, NUMCHARS), 0, 1, 0, 0.05, 0, 0, 0, 0, 15, left, top)
  end

end

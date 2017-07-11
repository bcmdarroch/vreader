-- LOVR callbacks
function lovr.load()
  require('lib/lua_lib')
  require('lib/lovr_lib')

  width, height = lovr.graphics.getDimensions()

  -- load model
  -- texture = lovr.graphics.newTexture('assets/texture.jpg')
  environment =  lovr.graphics.newModel('assets/Room_block_small.obj', 'assets/texture.jpg')


  -- load audio
  sound = lovr.audio.newSource('assets/background.ogg')
  sound:setLooping(true)

  -- load controllers
  controllers = lovr.headset.getControllers()

  -- load book/text
  -- font = lovr.graphics.newFont('assets/Arvo-Regular.ttf', '20')
  -- displayText = text -- from test.lua
  READMODE = false
  START = 1
  NUMWORDS = 100
  displayText = lovr.filesystem.read('assets/room/part1.txt')


end


function lovr.update(dt)
  -- test
  -- START = START + NUMWORDS * dt * .04
  -- print(START)
  -- print(NUMWORDS)

  -- has user clicked read mode?
  -- if controllers:getAxis('trigger') == 1 then
  --   READMODE = true
  -- end

  -- has user clicked next page?
  -- if controllers:isDown('touchpad') == 1 then
  -- --  START = START + NUMWORDS
  -- end

end


function lovr.draw()
  -- mac testing:
  lovr.graphics.plane('line', 0, 0, -1, 1, 0, 0, 1)
  lovr.graphics.print(lovr.printText(displayText, START, NUMWORDS), 0, 0, -1, 0.05, 0, 0, 0, 0, 10, left, top)

  -- play background sound
  sound:play()

  -- render environment given user's position in space
  environment:draw(0, 0, 0, .4)

  -- if read mode on, render page with in front of camera
  lovr.graphics.plane('line', 0, 1, 0, 1, 0, 0, 1)

  -- render text
  -- lovr.graphics.setShader(font) -- setShader/setFont doesn't work
  -- font:setPixelDensity(50)
  -- lovr.graphics.setColor(0, 0, 0, 255)
  lovr.graphics.print(lovr.printText(displayText, START, NUMWORDS), 0, 1, 0, 0.05, 0, 0, 0, 0, 10, left, top)

  -- render UI
  for i, controller in pairs(controllers) do
    local x, y, z = controller:getPosition()
    lovr.graphics.cube('line', x, y, z, 0.1, controller:getOrientation())
  end
end

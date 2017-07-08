-- LOVR callbacks
function lovr.load()
  -- require('functions')
  require('test')
  width, height = lovr.graphics.getDimensions()

  -- load model
  -- texture = lovr.graphics.newTexture('assets/texture.jpg')
  environment =  lovr.graphics.newModel('assets/Room_block_small.obj', 'assets/texture.jpg')


  -- load audio
  sound = lovr.audio.newSource('assets/background.ogg')
  sound:setLooping(true)

  -- load controllers
  controllers = lovr.headset.getControllers()

  -- load page (plane)


  -- load book/text
  -- font = lovr.graphics.newFont('assets/Arvo-Regular.ttf', '20')
  -- displayText = text -- from test.lua
  displayText = lovr.filesystem.read('assets/room/part1.txt')

end


function lovr.update()
  -- has user moved?

  -- has user clicked started read mode?

end


function lovr.draw()
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
  lovr.graphics.print(lovr.printText(displayText), 0, 1, 0, 0.05, 0, 0, 0, 0, 10, left, top)
  -- lovr.graphics.print(str, x, y, z, scale, angle, ax, ay, az, wrap, halign, valign)

  -- render UI
  for i, controller in pairs(controllers) do
    local x, y, z = controller:getPosition()
    lovr.graphics.cube('line', x, y, z, 0.1, controller:getOrientation())
  end
end

function lovr.printText(fullText)
  -- iterate over string, end string once 60 spaces counted
  local wordCount = 0
  for word in fullText:gmatch("%f[%w]") do
    -- while (wordCount < 500 or word ~= " ") do
    local wordCount = 0
    while wordCount < 500 do
      wordCount = wordCount + 1
    end
    return string.sub(fullText, 1, wordCount)
  end
  -- load 60 words at a time
end

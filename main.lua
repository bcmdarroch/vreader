function lovr.load()
  width, height = lovr.graphics.getDimensions()

  -- load model
  -- environment =  lovr.graphics.newModel('assets/Room_block.obj')

  -- load audio
  sound = lovr.audio.newSource('assets/background.ogg')
  sound:setLooping(true)

  -- load controllers
  controllers = lovr.headset.getControllers()

  -- load page (plane)


  -- load book/text
  -- font = lovr.graphics.newFont('assets/Arvo-Regular.ttf', '20')
  displayText = getText('assets/room/1.txt')

end

-- load functions

function getText(path)
  local textFile = io.open(path)
  -- print(textFile)
  local bookText = textFile:read("*a")
  -- print(bookText)
  textFile:close()

  return bookText
end

function lovr.update()
  -- has user moved?

  -- has user clicked started read mode?

end

-- update functions

function lovr.draw()
  -- test
  -- lovr.graphics.print("hello world!", 0, 0, -4)
  -- lovr.graphics.print("test", 0, 1, -2)
  -- lovr.graphics.plane('fill', -1, -1, -2, 1, .5, .5, .5)
  -- lovr.graphics.cube('line', 0, 0, -2, .5, lovr.timer.getTime())

  -- play background sound
  -- sound:play()

  -- render environment given user's position in space
  -- environment:draw(0, 0, -250, 1, 90)
  lovr.graphics.setBackgroundColor(230, 240, 255, 200)

  -- if read mode on, render page with in front of camera
  -- lovr.graphics.setShader(font) -- setShader/setFont doesn't work
  -- font:setPixelDensity(50)
  lovr.graphics.setColor(0, 0, 0, 255)
  lovr.graphics.print(displayText, 0, 0, -4)
  -- go to next line if LineWidth > width

  -- render UI
  for i, controller in pairs(controllers) do
    local x, y, z = controller:getPosition()
    lovr.graphics.cube('line', x, y, z, 0.2, controller:getOrientation())
  end
end

-- draw functions

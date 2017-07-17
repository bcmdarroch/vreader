-- main LOVR callbacks
function lovr.load()
  require('lib/book')
  require('lib/lua_lib')

  -- width, height = lovr.graphics.getDimensions()

  -- load model
  environment =  lovr.graphics.newModel('assets/Room_block_small.obj', 'assets/texture.jpg')

  -- load audio
  sound = lovr.audio.newSource('assets/background.ogg')
  sound:setLooping(true)

  -- load controllers
  refreshControllers()
  -- controller sphere (collider)

  -- load book/text (without book class)
  READMODE = false
  START = 1
  NUMWORDS = 100
  displayText = lovr.filesystem.read('assets/room/part1.txt')
  -- displayText = lovr.filesystem.read('assets/room/part1.txt') .. lovr.filesystem.read('assets/room/part2.txt') .. lovr.filesystem.read('assets/room/part3.txt') .. lovr.filesystem.read('assets/room/part4.txt') .. lovr.filesystem.read('assets/room/part5.txt') .. lovr.filesystem.read('assets/room/part6.txt')
  -- font = lovr.graphics.newFont('assets/Arvo-Regular.ttf', '20')

  -- load book w book class
  bookText = lovr.filesystem.read('assets/room/part1.txt')
  book = Book.new("A Room of One's Own", "Virginia Woolf", bookText)
  BX, BY, BZ = 0, 1, 0
  BAX, BAY, BAZ = 0, 0, 0
  planeSize = 1
  NX = 0
  NY = 0
  NZ = 1
  -- NZ = headset position
  textScale = 0.05
  angle = 0

  -- load physics
  -- world = lovr.physics.newWorld()
  -- bookCollider = world:newBoxCollider(BX, BY, BZ, 1, 1, 0.5)

  -- testCollider = world:newBoxCollider(BX, BY, BZ, 1, 1, 0.5)
end

function lovr.update()
  -- test
  -- START = START + NUMWORDS
  -- print(START)
  -- print(NUMWORDS)


  for i, controller in ipairs(controllers) do
    -- if trigger down and controller within book plane
    if controller:getAxis('trigger') == 1 and lovr.controllerPlaneCollide(controller) == true then
      -- print("in plane!", lovr.controllerPlaneCollide(controller))
      -- change book position
      BX, BY, BZ = controller:getPosition()

      -- translate rotation (keep forward vector of fixed toward headset)
      angle, BAX, BAY, BAZ = controller:getOrientation()
      -- lovr.graphics.rotate(angle, BAX, BAY, BAZ)
      transform = lovr.math.newTransform(BX, BY, BZ, 0, 0, 0, angle, BAX, BAY, BAZ)
    end
  end

end

function lovr.draw()
  -- mac testing:
  -- lovr.graphics.plane('line', 0, 0, -1, 1, 0, 0, 1)
  -- lovr.graphics.print(lovr.printText(displayText, START, NUMWORDS), 0, 0, -1, 0.05, 0, 0, 0, 0, 15, left, top)

  -- origin
  -- lovr.graphics.sphere(0, 0, 0, .1, 0, 0, 1)

  -- play background sound
  -- sound:play()

  -- render environment given user's position in space
  environment:draw(0, 0, 0, .4)

  -- render UI
  for i, controller in ipairs(controllers) do
   x, y, z = controller:getPosition()
   angle, ax, ay, az = controller:getOrientation()
   controllerModels[i]:draw(x, y, z, 1, angle, ax, ay, az)
  end

  -- if read mode on, render page with in front of camera
  if READMODE then
    -- without book class
    lovr.graphics.plane('line', BX, BY, BZ, 1, 0, 0, 1)

    -- render text
    -- lovr.graphics.setShader(font) -- setShader/setFont doesn't work
    -- font:setPixelDensity(50)
    -- lovr.graphics.setColor(0, 0, 0, 255)
    lovr.graphics.print(lovr.printText(displayText, START, NUMWORDS), BX, BY, BZ, 0.05, angle, BAX, BAY, BAZ, 10, left, top)

    -- with book class
    -- book:draw('line', BX, BY, BZ, planeSize, NX, NY, NZ, textScale, angle, BAX, BAY, BAZ)
  end

end


-- controller functions
function refreshControllers()
  controllers = lovr.headset.getControllers()
  controllerModels = {}
  for i, controller in ipairs(controllers) do
    controllerModels[i] = controller:newModel()
  end
end

function lovr.controlleradded()
  refreshControllers()
end

function lovr.controllerremoved()
  refreshControllers()
end

function lovr.controllerpressed(controller, button)
  if button == 'menu' then
    READMODE = not READMODE
  end

  if button == 'touchpad' then
    if controller:getAxis('touchx') > 0 then
      START = START + NUMWORDS
      if START > string.len(displayText) then
        START = string.len(displayText) - NUMWORDS
      end
    elseif controller:getAxis('touchx') < 0 then
      START = START - NUMWORDS
      if START < 1 then
        START = 1
      end
    end

  end

end


-- control book position
function lovr.controllerPlaneCollide(controller)
  -- get controller position
  conX, conY, conZ = controller:getPosition()
    -- print("controller points", conX, conY, conZ, conAngle, conAX, conAY, conAZ)

  -- get distance btwn plane and controller origins (position - position)
  deltaX = BX - conX
  deltaY = BY - conY
  deltaZ = BZ - conZ
  d = deltaX^2 + deltaY^2 + deltaZ^2
  distance = math.sqrt(d)

  if distance < 0.5 then
    return true
  else
    return false
  end
end

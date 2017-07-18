-- 1. main LOVR callbacks
function lovr.load()
  require('lib/book')
  require('lib/lua_lib')

  -- load environment
  environment =  lovr.graphics.newModel('assets/Room_block_small.obj', 'assets/texture.jpg')

  -- load audio
  sound = lovr.audio.newSource('assets/background.ogg')
  sound:setLooping(true)

  -- load controllers
  refreshControllers()

  -- load book
  bookText = lovr.filesystem.read('assets/room/part1.txt') .. lovr.filesystem.read('assets/room/part2.txt') .. lovr.filesystem.read('assets/room/part3.txt') .. lovr.filesystem.read('assets/room/part4.txt') .. lovr.filesystem.read('assets/room/part5.txt') .. lovr.filesystem.read('assets/room/part6.txt')
  book = Book:init("A Room of One's Own", "Virginia Woolf", bookText)
  -- font = lovr.graphics.newFont('assets/Arvo-Regular.ttf', '20')

  PAGE = 1
  BX, BY, BZ = 0, 1, 0
  BAX, BAY, BAZ = 0, 0, 0
  planeSize = 1

  textScale = 0.05
  angle = 0
  rotateMode = false

end

function lovr.update()
  book:update()

end

function lovr.draw()
  -- mac testing:
  -- book:draw(PAGE, 'fill', 0, 0, -1, planeSize, NX, NY, NZ, textScale, angle, BAX, BAY, BAZ)

  -- origin
  -- lovr.graphics.sphere(0, 0, 0, .1, 0, 0, 1)

  -- play background sound
  -- sound:play()

  -- render environment given user's position in space
  environment:draw(0, 0, 0, .4)

  -- render UI
  renderControllers()

  -- render book
  book:draw(PAGE, 'fill', BX, BY, BZ, planeSize, textScale, angle, BAX, BAY, BAZ)
  -- inverse: line vs fill

  -- second: artisanal hand-crafted rotation
  -- if rotateMode then
  --   for i, controller in ipairs(controllers) do
  --     lovr.graphics.push()
  --     lovr.graphics.origin()
  --     lovr.graphics.translate(controller:getOrientation()) -- the x, y, z of the plane, maybe controller:getPosition or something
  --     lovr.graphics.rotate(controller:getOrientation())
  --     book:draw(PAGE, 'line', 0, 0, 0, planeSize, NX, NY, NZ, textScale, angle, 0, 0, 0)
  --     lovr.graphics.pop()
  --     rotateMode = false
  --   end
  -- end

end

-- 2. controller functions
function refreshControllers()
  controllers = lovr.headset.getControllers()
  controllerModels = {}
  for i, controller in ipairs(controllers) do
    controllerModels[i] = controller:newModel()
  end

end

function renderControllers()
  for i, controller in ipairs(controllers) do
   x, y, z = controller:getPosition()
   angle, ax, ay, az = controller:getOrientation()
   controllerModels[i]:draw(x, y, z, 1, angle, ax, ay, az)
  end

end

function lovr.controlleradded()
  refreshControllers()

end

function lovr.controllerremoved()
  refreshControllers()

end

function lovr.controllerpressed(controller, button)
  if button == 'touchpad' then
    book:turnPage(controller)
  end

  if button == 'grip' then
    book:inverseColors()
  end

end

-- check controller position relative to book
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

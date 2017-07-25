require('lib/book')
require('lib/library')

viewport = {
  viewMatrix = lovr.math.newTransform()
}

-- 1. main LOVR callbacks
function lovr.load()
  -- load shader
  -- roomShader = require 'lib/zephyr'
  simpleShader = require 'lib/simple'

  -- load environment & skybox
  -- environment =  lovr.graphics.newModel('assets/models/Room_block_small.obj', 'assets/textures/texture.jpg')
  bed = lovr.graphics.newModel('assets/models/Bed.obj', 'assets/textures/Bed_diffuse.png')
  chair = lovr.graphics.newModel('assets/models/Chair.obj', 'assets/textures/texture.jpg')
  desk = lovr.graphics.newModel('assets/models/Desk.obj', 'assets/textures/Desk_diffuse.png')
  painting = lovr.graphics.newModel('assets/models/Painting.obj', 'assets/textures/Instruction_frame1.png')
  shelf = lovr.graphics.newModel('assets/models/Shelf.obj', 'assets/textures/Shelf_diffuse.png')
  window = lovr.graphics.newModel('assets/models/Window.obj', 'assets/textures/texture.jpg')
  environment = { bed, chair, desk, painting, shelf, window }

  wall = lovr.graphics.newModel('assets/models/Wall.obj', 'assets/textures/texture.jpg')
  skybox = lovr.graphics.newSkybox('assets/rainy_sky.jpg')

  -- load room collider
  -- world = lovr.physics.newWorld()
  -- box = world:newBoxCollider(0, 0, 0, 1, 1, 1)

  -- load audio
  sound = lovr.audio.newSource('assets/rain.ogg')
  sound:setLooping(true)

  -- load controllers
  refreshControllers()

  -- load library & active book
  library = Library()
  library:load()
  activeBook = library.books['Room']['book']
  -- print('activeBook', activeBook.title)

  -- set font
  font = lovr.graphics.newFont('assets/Arvo-Regular.ttf', 48)
  lovr.graphics.setFont(font)

end

function lovr.draw()

  -- play background sound
  -- sound:play()

  -- render skybox
  local angle, x, y, z = lovr.headset.getOrientation()
  lovr.graphics.setShader()
  skybox:draw(-angle, x, y, z)

  -- render books
  library:draw()
  activeBook:draw()

  -- render UI
  renderControllers()

  -- render room shader
  lovr.graphics.setShader(simpleShader)
  -- lovr.graphics.setShader(roomShader)
  viewport.viewMatrix:origin()
  viewport.viewMatrix:translate(lovr.headset.getPosition())
  viewport.viewMatrix:rotate(lovr.headset.getOrientation())
  -- roomShader:send('zephyrView', viewport.viewMatrix:inverse())
  -- roomShader:send('ambientColor', { .5, .5, .5 })

  -- render room
  -- environment:draw(0, 0, 0,0.4)
  for i, object in ipairs(environment) do
    object:draw(0, 0, 0, 0.3)
  end
  wall:draw(0, 0, 0, 0.3, 0)
  wall:draw(0, 0, 0, 0.3, math.rad(90))
  wall:draw(0, 0, 0, 0.3, math.rad(270))


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
  -- if button is menu, check if a book is selected

  if button == 'touchpad' then
    activeBook:turnPage(controller)
  end

  if button == 'grip' then
    activeBook:inverseColors()
  end

end

-- check controller position relative to book
function lovr.controllerPlaneCollide(controller)
  -- get controller position
  conX, conY, conZ = controller:getPosition()

  -- get distance btwn plane and controller origins (position - position)
  deltaX = activeBook.x - conX
  deltaY = activeBook.y - conY
  deltaZ = activeBook.z - conZ
  d = deltaX^2 + deltaY^2 + deltaZ^2
  distance = math.sqrt(d)

  if distance < 0.5 then
    return true
  else
    return false
  end

end

-- check what book should be active
-- if controller is colliding with the book model,
  -- then change that book to activeBook

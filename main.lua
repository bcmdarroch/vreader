require('lib/book')
require('lib/library')

viewport = {
  viewMatrix = lovr.math.newTransform()
}

-- 1. main LOVR callbacks
function lovr.load()
  -- load shader
  simpleShader = require 'lib/simple'

  -- load environment & skybox
  SCALE = 0.3
  bed = lovr.graphics.newModel('assets/models/Bed.obj', 'assets/textures/Bed_diffuse.png')
  chair = lovr.graphics.newModel('assets/models/Chair.obj', 'assets/textures/Chair_diffuse.png')
  desk = lovr.graphics.newModel('assets/models/Desk.obj', 'assets/textures/Desk_diffuse.png')
  painting = lovr.graphics.newModel('assets/models/Painting.obj', 'assets/textures/Instruction_frame_diffuse.png')
  shelf = lovr.graphics.newModel('assets/models/Shelf.obj', 'assets/textures/Shelf_diffuse.png')
  window = lovr.graphics.newModel('assets/models/Window.obj', 'assets/textures/window_diffuse.png')
  floor = lovr.graphics.newModel('assets/models/Floor.obj', 'assets/textures/Floor_diffuse.png')
  ceiling = lovr.graphics.newModel('assets/models/Ceiling.obj', 'assets/textures/Ceiling_diffuse.png')
  environment = { bed, desk, painting, shelf, window, floor, ceiling }

  wall = lovr.graphics.newModel('assets/models/Wall.obj', 'assets/textures/wall_diffuse.png')
  skybox = lovr.graphics.newSkybox('assets/garden.jpg')

  -- load audio
  sound = lovr.audio.newSource('assets/birds.ogg')
  lovr.audio.setVolume(2)
  sound:setLooping(true)

  -- load controllers
  refreshControllers()

  -- load library & active book
  library = Library()
  library:load()
  activeBook = library.books['Room']['book']
  activeBook.x, activeBook.y, activeBook.z = library.books['Room']['position']:transformPoint(0, 0, 0)
  activeBook.y = activeBook.y + 0.5
  activeBook.angle = math.rad(90)
  activeBook.ay = 1

  -- set font
  font = lovr.graphics.newFont('assets/Arvo-Regular.ttf', 48)
  lovr.graphics.setFont(font)

end

function lovr.draw()
  -- play background sound
  sound:play()

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
  viewport.viewMatrix:origin()
  viewport.viewMatrix:translate(lovr.headset.getPosition())
  viewport.viewMatrix:rotate(lovr.headset.getOrientation())

  -- render room
  for i, object in ipairs(environment) do
    object:draw(0, 0, 0, SCALE)
  end
  chair:draw(-0.1, 0, 0, SCALE + 0.05, 0)
  wall:draw(0, 0, 0, SCALE, 0)
  wall:draw(0, 0, 0, SCALE, math.rad(90))
  wall:draw(0, 0, 0, SCALE, math.rad(270))

  -- make room collider
  -- world = lovr.physics.newWorld()
  -- box = world:newBoxCollider(0, 0, 0, 2, 2, 2)

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
  if button == 'menu' then
    activeBook = lovr.getSelectedBook(controller)['book']
    activeBook.x, activeBook.y, activeBook.z = lovr.getSelectedBook(controller)['position']:transformPoint(0, 0, 0)
    activeBook.y = activeBook.y + 0.5
  end

  if button == 'touchpad' then
    activeBook:turnPage(controller)
  end

  if button == 'grip' then
    activeBook:inverseColors()
  end

end

-- check controller position relative to book plane
function lovr.controllerPlaneCollide(controller)
  -- get controller position
  conX, conY, conZ = controller:getPosition()

  -- get distance btwn plane and controller origins
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

-- check controller position relative to book models
function lovr.getSelectedBook(controller)
  conX, conY, conZ = controller:getPosition()

  for i, book in pairs(library.books) do
    local x, y, z = book['position']:transformPoint(0, 0, 0)

    local deltaX = x - conX
    local deltaY = y - conY
    local deltaZ = z - conZ
    d = deltaX^2 + deltaY^2 + deltaZ^2
    distance = math.sqrt(d)

    if distance < 0.5 then
      return book
    end
  end
  return activeBook

end

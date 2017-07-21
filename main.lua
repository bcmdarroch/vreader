-- 1. main LOVR callbacks
function lovr.load()
  require('lib/book')
  require('lib/library')

  -- load environment & skybox
  environment =  lovr.graphics.newModel('assets/Room_block_small.obj', 'assets/texture.jpg')
  skybox = lovr.graphics.newSkybox('assets/water.jpg')

  -- load audio
  sound = lovr.audio.newSource('assets/background.ogg')
  sound:setLooping(true)

  -- load controllers
  refreshControllers()

  -- load book
  -- bookText = lovr.filesystem.read('assets/books/room/part1.txt') .. lovr.filesystem.read('assets/books/room/part2.txt') .. lovr.filesystem.read('assets/books/room/part3.txt') .. lovr.filesystem.read('assets/books/room/part4.txt') .. lovr.filesystem.read('assets/books/room/part5.txt') .. lovr.filesystem.read('assets/books/room/part6.txt')
  -- activeBook = Book:init("A Room of One's Own", "Virginia Woolf", bookText)
  library = Library:init()
  activeBook = library.books['Room']['book']
  font = lovr.graphics.newFont('assets/Arvo-Regular.ttf', 48)
  lovr.graphics.setFont(font)

end

function lovr.draw()
  -- origin:
  -- lovr.graphics.sphere(0, 0, 0, .1, 0, 0, 1)

  -- play background sound
  -- sound:play()

  -- render skybox
  local angle, x, y, z = lovr.headset.getOrientation()
  skybox:draw(-angle, x, y, z)

  -- render environment given user's position in space
  -- environment:draw(0, 0, 0, .4)

  -- render UI
  renderControllers()

  -- render book
  activeBook:draw()
  -- draw activebook only

  --drawActive
  --drawLibrary (places nonactive books in scene)

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

  -- get distance btwn plane and controller origins (position - position)
  deltaX = book.x - conX
  deltaY = book.y - conY
  deltaZ = book.z - conZ
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

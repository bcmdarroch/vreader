function lovr.load()
-- load book/text

-- load model
  -- environment =  lovr.graphics.newModel('assets/Room_block.obj')

-- load audio

-- load controllers

-- load page (plane)

end

function lovr.update()
  -- has user moved?

  -- has user

end

function lovr.draw()
-- test
  -- lovr.graphics.cube('line', 0, 0, -2)
  lovr.graphics.print("hello world!", -1, -1, -2)
  lovr.graphics.plane("fill", -1, -1, -2, 1, .5, .5, .5)

-- render environment given user's position in space
  -- environment:draw(0, 0, -250, 1, 90)
  -- lovr.graphics.setBackgroundColor(0, 0, 255, 255)

-- if read mode on, render page with in front of camera

-- render UI

end

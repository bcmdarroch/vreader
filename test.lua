-- text = io.open('assets/room/1.txt', "r");
-- displayText = io.read('assets/room/1.txt', '*all')
-- print(displayText)

function readText(path)
  local f = io.open('assets/room/1.txt')
  local s = f:read("*a")
  -- print(s)
  f:close()

  return s
end

print(readText('assets/room/1.txt'))

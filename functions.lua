function getText(path)
  -- local textFile = io.open(path)
  local text = io.open(path):read("*a")
  -- print(text)
  textFile:close()

  return text
end

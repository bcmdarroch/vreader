-- checks for controllers
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

-- prints section of text
function lovr.printText(fullText, start, numWords)
  -- split text by word into table
  -- local words = {}
  -- for word in fullText:gmatch("%S+") do
  --   table.insert(words, word)
  -- end
  --
  -- -- adjust finish variable if needed
  -- local finish = start + numWords
  -- if finish > tableLength(words) then
  --   finish = tableLength(words)
  -- end
  --
  -- -- return section of text
  -- return table.concat(words, " ", start, finish)

  -- split by characters
  local charCount = 0
  -- for char in fullText:gmatch("()%f[%w]") do
  for char in fullText:gmatch(".") do
    charCount = charCount + 1
    if charCount > numWords then
      -- 1. in btwn words
      -- 2. at end of words
      -- 3. inside word

      -- check next character
      -- if it's space, return charCount
      -- if it's another letter, go backward
      -- while prev character is not a space, subtract from charCount

       return string.sub(fullText, start, start + charCount)
     end
   end
end

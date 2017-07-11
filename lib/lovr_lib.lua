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
  local words = {}
  for word in fullText:gmatch("%S+") do
    -- count new lines!
    table.insert(words, word)
  end

  -- adjust finish variable if needed
  local finish = start + numWords
  if finish > tableLength(words) then
    finish = tableLength(words)
  end

  -- return section of text
  return table.concat(words, " ", start, finish)
end

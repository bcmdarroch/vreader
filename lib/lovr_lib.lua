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
function lovr.printText(fullText, start, fin)
  -- adjust finish if needed
  if fin > string.len(fullText) then
    fin = string.len(fullText)
  end

  -- split by characters
  local i = 0
  for char in fullText:gmatch(".") do
    i = i + 1

    if i == fin then
      local next = string.sub(fullText, i + 1, i + 1)

      -- 1. end of word
      -- 2. in btwn words
      if char == " " or next == " " then
        return string.sub(fullText, start, i)

      -- 3. inside word
      elseif char ~= " " and next ~= " " then
        local prev = ""
        repeat
          i = i - 1
          prev = string.sub(fullText, i - 1, i - 1)
        until prev == " "

        return string.sub(fullText, start, i - 1)
      end
    end
  end
end

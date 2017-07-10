function printText(fullText, start)
  -- iterate over string, end string once 60 spaces counted
  local words = {}
  for word in fullText:gmatch("%S+") do
    table.insert(words, word)
  end

  local finish = start + 10
  if finish > tableLength(words) then
    finish = tableLength(words)
  end

  return table.concat(words, " ", start, finish)
  --   -- while (wordCount < 500 or word ~= " ") do
  --   local wordCount = 0
  --   while wordCount < 10 do
  --     wordCount = wordCount + 1
  --   end
    -- return string.sub(fullText, start, wordCount)
  -- end
  -- load 60 words at a time

  -- try space count?
end

function tableLength(table)
  local count = 0
  for _ in pairs(table) do count = count + 1 end
  return count
end

print(printText('here I am listening to my brother my brother and me, trying not to fall asleep la la la la la hahaha. whoa whoa whoa!! hi', 5))

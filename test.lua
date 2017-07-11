function printText(fullText, start, numWords)
  -- iterate over string, end string once 60 spaces counted
  -- local words = {}
  local words = 0
  local section = ""
  for word in fullText:gmatch("%S+") do
    -- table.insert(words, word)
    words = words + 1
    -- section = section .. word
    if words >= numWords then
      return string.sub(fullText, start, numWords)
    end
  end

  -- local finish = start + numWords
  -- if finish > tableLength(words) then
  --   finish = tableLength(words)
  -- end

  -- return table.concat(words, " ", start, finish)

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

text = 'here I am listening to my brother my brother and me, trying not to fall asleep la la la la la hahaha. whoa whoa whoa!! gotta test this thing hmm yep seems about right. '
start = 1
num = 5

for i = 1, 5 do
  print(printText(text, start, num))
  start = start + num
end

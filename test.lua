function printText(fullText, start, numChars)
  -- YUP: splits on characters
    --  local charCount = 0
    --  for char in fullText:gmatch("%w+") do
    --   charCount = charCount + 1
    --   if charCount > numChars then
        -- print("start in function", start)
        -- print("num in function", num)
        -- return string.sub(fullText, start, numChars)
    -- end
  -- end

  -- NOPE: iterate over string, end string once 60 spaces counted
  --  local wordCount = 0
  -- for word in fullText:gmatch("%w+") do
  -- -- for word in fullText:gmatch("()%f[%w]") do
  --   -- figure out gmatch
  --    wordCount = wordCount + 1
  --    textToDisplay = textToDisplay .. word
  --   if wordCount == 60 then
  --     return textToDisplay
  --   if wordCount > 500 then
  --     return string.sub(fullText, 1, wordCount)
  --    end
  --  end

  -- YUP: but no paragraphs preserved
  --  local words = {}
  -- for word in fullText:gmatch("%S+") do
  --   -- count new lines!
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


  -- MAYBE?
  -- split by \n new paragraph
  -- local paragraphs = {}
    -- split text by word into table
  -- local paragraphs = {}
  -- for paragraph in fullText:gmatch("[^\r,]+") do
  --   -- table.insert(paragraphs, paragraph)
  --   local words = {}
  --   for word in paragraph:gmatch("%S+") do
  --     table.insert(words, word)
  --   end
  --
  --   table.insert(paragraphs, words)
  --   for k, v in pairs(paragraphs) do
  --     for k, v in pairs(words) do
  --       -- print(k, v)
  --       para = table.concat(words, " ")
  --     end
  --     text = para .. "\n"
  --   end
  --   return text
  -- end


  -- NOPE: while (numWords < 500 or word ~= " ") do
  --   local numWords = 0
  --   while numWords < 10 do
  --     numWords = numWords + 1
  --   end
  --   return string.sub(fullText, start, numWords)
  -- end
  -- load 60 words at a time

  -- NOPE: until string[numWords] is a space
  -- print("outside loop", numWords)
  -- while string.sub(fullText, numWords, numWords):match("%w+") do
  --   print("before", numWords)
  --   numWords = numWords - 1
  --   print("after", numWords)
  -- end
  -- -- add 1 to wordCount
  -- return string.sub(fullText, start, numWords)


  -- NOPE
  -- local wordCount = 0
  -- for word in fullText:gmatch("%S+") do
  --   -- repeat
  --   if wordCount < numWords then
  --     wordCount = wordCount + 1
  --     print("word: ", word)
  --   -- until wordCount > numWords
  --   else
  --     -- split = word:match'^.*()/'
  --     -- split = string.find(word, "/[^/]*$")
  --     -- find index of last character in word (how??)
  --     print('split: ', split)
  --     return string.sub(fullText, start, split)
  --   end
  -- end
end

function tableLength(table)
  local count = 0
  for _ in pairs(table) do count = count + 1 end
  return count
end

text = [[ here I am listening to my brother my brother and me, trying not to fall asleep la la la la la hahaha.

whoa whoa whoa!!

gotta test this thing hmm yep seems about right.

hiiya new line here i am ]]
start = 1
num = 5

for i = 1, 30 do
  -- print("'" .. printText(text, start, num) .. "'")
  -- start = start + num
  -- print("what the text", text)
  -- print("start: ", start)
  -- print("num words: ", num)

  print(string.sub(text, i, i + 5))
end

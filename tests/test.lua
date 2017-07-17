function parseTxt(text)
  textTable = {}

  local i = 1
  local j = 10

  while j <= string.len(text) do

    local char = string.sub(text, j, j)
    local next = string.sub(text, j + 1, j + 1)

    -- 1. end of word
    -- 2. in btwn words
    if char == " " or next == " " then
      -- add string.sub(text, i, j) to text table

    -- 3. inside word
    elseif char ~= " " and next ~= " " then
      local prev = ""
      repeat
        j = j - 1
        prev = string.sub(text, j - 1, j - 1)
      until prev == " "
      -- add string.sub(text, i, i) to text table
    end

    -- i = j
    -- j = i + 50
  end

  return textTable

end

text = [[me creating new accounts to get one month free trials

Hairy frogfish have excellent camouflage.]]

-- function printText(fullText, start, numChars)
--   -- split by characters
--   local i = 0
--   for char in fullText:gmatch(".") do
--     i = i + 1
--
--     if i == numChars then
--       print("text", fullText)
--       print("last char", "'" .. char .. "'")
--       print("i", i)
--       local next = string.sub(fullText, i + 1, i + 1)
--       print("next", "'" .. next .. "'")
--
--       -- 1. end of word
--       -- 2. in btwn words
--       if char == " " or next == " " then
--         return string.sub(fullText, start, start + i - 1)
--
--       -- 3. inside word
--       elseif char ~= " " and next ~= " " then
--         print("inside word")
--         local prev = ""
--         repeat
--           i = i - 1
--           print("i", i)
--           prev = string.sub(fullText, i - 1, i - 1)
--           print("prev", prev)
--         until prev == " "
--         i = i - 1
--
--         return string.sub(fullText, start, start + i)
--       end
--     end
--   end
-- end

-- text = [[me creating new accounts to get one month free trials
--
-- Hairy frogfish have excellent camouflage.]]

-- end of word
-- print('Test 1', "'" .. printText(text, 1, 11) .. "'") -- [[me creating]]

-- inside word
-- print('Test 2 (inside word)', "'" .. printText(text, 1, 72) .. "'") -- [[me creating new accounts to get one month free trials

-- Hairy frogfish ]] -- ha

-- print('Test 2.1 (inside word)', "'" .. printText(text, 1, 20) .. "'") -- [[me creating new -- acco]]

-- print('Test 2.2 (inside word)', "'" .. printText(text, 1, 8) .. "'") -- [[me -- creat]]

-- btwn words
-- print('Test 3', "'" .. printText(text, 1, 61) .. "'") -- [[me creating new accounts to get one month free trials

-- Hairy ]]

-- local start = 1
-- for i = 1, 6 do
--   print('Test ' .. i .. '', "'" .. printText(text, start, 15) .. "'")
--   start = start + 15
--   print("~~~~~~~~~~~~")
-- end




-- local lust = require('lust')
-- local describe, it, expect = lust.describe, lust.it, lust.expect
--
-- describe("printText", function()
--   lust.before(function()
--     text = [[me creating new accounts to get one month free trials
--
--     Hairy frogfish have excellent camouflage.]]
--   end)
--
--   it("returns substring of correct or lesser length", function()
--     local length = string.len(lovr.printText(text, 1, 11))
--     expect(length).to.equal(11)
--   end)
--
--   it("returns correct substring", function()
--     expect(lovr.printText(text, 1, 53)).to.equal('me creating new accounts to get one month free trials')
--   end)
--
--   it("correctly handles if last character is end of a word", function()
--     expect(lovr.printText(text, 1, 41)).to.equal('me creating new accounts to get one month')
--   end)
--
--   it("correctly handles if last character is between words", function()
--     expect(lovr.printText(text, 1, 110)).to.equal([[me creating new accounts to get one month free trials
--
--     Hairy frogfish have excellent camouflage.
--
--     Why ]])
--   end)
--
--   it("correctly handles if last character is inside word", function()
--     expect(lovr.printText(text, 1, 70)).to.equal([[me creating new accounts to get one month free trials
--
--     Hairy ]])
--   end)
-- end)

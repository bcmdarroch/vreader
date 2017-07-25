local htmlparser = require('lib/htmlparser/init')

-- epub unzipper block
-- 1. retrieve most recently modified epub in assets/books and save filename to variable
-- os.execute([[ls -t assets/books | grep '.epub' > tests/outfile.txt]])
-- io.input("tests/outfile.txt")
-- fileName = io.read()

-- 2. save filename without extension
-- dirName = string.match(fileName, '(.+)%p')
--
-- print("file", fileName)
-- print("dir", dirName)

-- 3. unzip epub
-- hardcoded:
-- os.execute("7z e assets/books/Emma.epub -oassets/books/unzipped/Emma *.html -r")
-- os.execute("7z e assets/books/" .. fileName .. " -oassets/books/unzipped/" .. dirName .. " *.htm *.html -r -aos")

-- HTML parser test
local file = io.input('assets/books/unzipped/Emma/@public@vhost@g@gutenberg@html@files@158@158-h@158-h-0.htm.html')
local rawText = io.read("*a") file:close()

local root = htmlparser.parse(rawText)
-- print("type:", type(root))
-- print("root", root)

-- select all paragraphs except for Table of Contents
local elements = root:select("p:not(.toc)")

local text = ""
for _, e in ipairs(elements) do
  -- get p-tag content
  -- print(e:getcontent())
  text = text .. "\n" .. e:getcontent()
end

-- strip HTML word styling
-- print("text before", text)
text = string.gsub(text, "<(.)>", "")
text = string.gsub(text, "<(.+)/>", "")
text = string.gsub(text, "</(.)>", "")
-- text = string.gsub(text, [[<a id="link2HCH0004"><!--  H2 anchor -->]], "")
print("text after", text)

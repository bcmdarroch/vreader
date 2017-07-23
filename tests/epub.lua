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
io.input('assets/books/unzipped/Emma/@public@vhost@g@gutenberg@html@files@158@158-h@158-h-0.htm.html')
rawText = io.read("*a")
-- print(rawText)
-- print("type:", type(rawText))

-- local parsedHTML = htmlparser.parse(rawText)
-- print("1:", rawText[1])
-- print("2:", rawText[2])

-- htmlparser not working, next try pattern matching
print(string.match(rawText, "<p>(.+)</p>"))

--
-- for i, paragraph in ipairs(rawText) do
--   print("paragraph", paragraph)
--   print("p-tag selected", paragraph("p"))
-- end

-- in each file, parse for p text after h1 id "pgepubid00001", add to text string
-- local paragraphs = rawText:select("p")
-- for i, paragraph in ipairs(paragraphs) do
--   print(i .. paragraph)
-- end

-- return parsed text string

local htmlparser = require('lib/htmlparser/init')

-- retrieve most recently modified epub in assets/books and save filename to variable
os.execute([[ls -t assets/books | grep '.epub' > tests/outfile.txt]])
file = io.input("tests/outfile.txt")
fileName = io.read()

-- save filename without extension
dirName = string.match(fileName, '(.+)%p')

print("file", fileName)
print("dir", dirName)

-- unzip epub
-- hardcoded:
-- os.execute("7z e assets/books/Emma.epub -oassets/books/unzipped/Emma *.html -r")
os.execute("7z e assets/books/" .. fileName .. " -oassets/books/unzipped/" .. dirName .. " *.htm *.html -r -aos")
-- os.execute("unzip assets/books/" .. fileName .. " -oassets/books/unzipped/" .. dirName .. " *.html -r")

-- iterate over files in filename
-- local rawText = htmlparser.parse(book)
-- for i, text in ipairs(rawText) do
--   print(i .. text)
-- end

  -- parse first h1 for title

  -- parse first h2 for author

  -- in each file, parse for p text after h1 id "pgepubid00001", add to text string
  -- local paragraphs = rawText:select("p")
  -- for i, paragraph in ipairs(paragraphs) do
  --   print(i .. paragraph)
  -- end

-- return text string (to be fed to book:init)

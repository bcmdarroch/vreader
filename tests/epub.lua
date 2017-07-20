local htmlparser = require('lib/htmlparser/init')
-- local snappy = require('../lib/lua-csnappy')

-- open epub?
local book = io.open("assets/Emma.epub", "r")
print(book)

-- unzip epub
-- local epub = snappy.decompress("assets/Emma.epub")
-- print(epub)

-- open OEBPS folder

-- iterate over files in OEBPS
local rawText = htmlparser.parse(book)
  -- parse first h1 for title

  -- parse first h2 for author

  -- in each file, parse for p text after h1 id "pgepubid00001", add to text string
  local paragraphs = rawText:select("p")

-- return text string (to be fed to book:init)

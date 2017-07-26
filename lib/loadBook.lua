-- epub unzipper
-- 1. retrieve most recently modified epub in assets/books and save filename to variable
os.execute([[ls -t assets/books | grep '.epub' > tests/outfile.txt]])
io.input("tests/outfile.txt")
fileName = io.read()

-- 2. save filename without extension
dirName = string.match(fileName, '(.+)%p')

-- 3. unzip epub and save in unzipped/filename
-- will not overwrite if book already in unzipped directory
os.execute("7z e assets/books/" .. fileName .. " -oassets/books/unzipped/" .. dirName .. " *.htm *.html -r -aos")

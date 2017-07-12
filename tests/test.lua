local lust = require('lust')
local describe, it, expect = lust.describe, lust.it, lust.expect

describe("printText", function()
  lust.before(function()
    text = [[me creating new accounts to get one month free trials

    Hairy frogfish have excellent camouflage.

    Why Romance languages gotta be so extra about verb conjugations]]
  end)

  it("returns substring of correct or lesser length", function()
    local length = string.len(lovr.printText(text, 1, 11))
    expect(length).to.equal(11)
  end)

  it("returns correct substring", function()
    expect(lovr.printText(text, 1, 53)).to.equal('me creating new accounts to get one month free trials')
  end)

  it("correctly handles if last character is end of a word", function()
    expect(lovr.printText(text, 1, 41)).to.equal('me creating new accounts to get one month')
  end)

  it("correctly handles if last character is between words", function()
    expect(lovr.printText(text, 1, 110)).to.equal([[me creating new accounts to get one month free trials

    Hairy frogfish have excellent camouflage.

    Why ]])
  end)

  it("correctly handles if last character is inside word", function()
    expect(lovr.printText(text, 1, 70)).to.equal([[me creating new accounts to get one month free trials

    Hairy ]])
  end)
end)

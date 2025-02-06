local ic = require("src.icecream")

local function testPosition()
    local x = 1
    local y = 1

    ic(x,y)

    ic:SetIsOutPutPosition(true)

    ic(x,y)
    ic:SetIsOutPutPosition(false)
end

local function testPrefix()
    local x = 1
    ic(x)

    ic:SetPrefix('arst')
    ic(x)

    ic:ResetPrefix()
    ic(x)
end

local function testIC()
    local x = 1
    local y = 2
    ic(x,y)
end

local function testNoName()
    ic(1,2)
end

local function testNoArg()
    ic()
end


local function testFunc()
    local a1 = 11
    local function func(a)
        return a + 23
    end
    ic(func(a1))
end

local function testDisable()
    local noPrint = "no print"
    ic:Disable()
    ic(noPrint)
end

local function testEnable()
    local yesPrint = "yes print"
    ic:Enable()
    ic(yesPrint)
end

print('---- test ic')
testIC()
print('---- test prefix')
testPrefix()
print('---- test positoin')
testPosition()
print('---- test no name')
testNoName()
print('---- test no args')
testNoArg()
print('---- test function')
testFunc()
print('---- test disable')
testDisable()
print('---- test enable')
testEnable()

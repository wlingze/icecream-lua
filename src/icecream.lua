local find   = string.find
local sub    = string.sub
local match  = string.match

---Just call IceCream()
---`getmetatable(IceCream).__call = IceCreamDebug()`
---
---@class IceCream
local IceCream = {
    prefixString = "ic| ",
    isOutputPosition = false,
    isPrintEnabled = true
}

---Print the msg to stderr
---@param msg string
local function OutputFunction(msg)
    local stderr = io.stderr
    stderr:write(msg)
end

---Split logStr with breakpointsStr into a table
---@param logStr string
---@param breakpointsStr string
---@return table
local function split(logStr,breakpointsStr)
    local i = 0
    local j = 1
    local t = {}
    local z = #breakpointsStr
    while true do
        i = find(logStr, breakpointsStr, i + 1)
        if i == nil then
            t[#t+1] = sub(logStr, j, -1)
            break
        end
        t[#t+1] = sub(logStr, j, i-1)
        j = i + z
    end
    return t
end

---Read the corresponding line of the file
---@param filename string
---@param line string
---@return table
local function ReadSource(filename, line)
    local file_fd = io.open(filename, 'r')
    return split(file_fd:read("a"), '\n')[tonumber(line)]
end

---Take out the substring in the parentheses in the string
---@param source string
---@return string
local function MatchParenthese(source)
    local allNameStr
    allNameStr = match(source, "(%b())")
    allNameStr = sub(allNameStr, 2, #allNameStr-1)
    return allNameStr
end


---Process and print the corresponding variable name and variable value
function IceCream:IceCreamDebug(...)
    local value,  vname, msg, allName, source, stack
    local lenOfValues = select("#", ...)
    local line, filename, buf

    stack = match(split(debug.traceback(), '\n')[3], "^%s*(.-)%s*$")
    buf = split(stack, ':')
    filename = buf[1]
    line = buf[2]

    if(self.isOutputPosition) then
        OutputFunction(stack .. '\n')
    end

    OutputFunction(self.prefixString)

    if lenOfValues == 0 then
        OutputFunction(stack .. '\n')
    else
        source = ReadSource(filename, line)
        allName = split(MatchParenthese(source), ',')

        for i = 1, lenOfValues do
            value = tostring(select(i, ...))
            vname = match(allName[i], "^%s*(.-)%s*$")

            if(value == vname) then
                msg = vname
            else
                msg = vname .. ' = ' ..value
            end
            if(i == lenOfValues) then
                msg = msg .. '\n'
            else
                msg = msg .. ', '
            end
            OutputFunction(msg)
        end
    end

end

---Set whether to print the corresponding file and address
---@param val boolean
function IceCream:SetIsOutPutPosition(val)
    self.isOutputPosition = val
end

---Set the prefix string for printing
---@param val string
function IceCream:SetPrefix(val)
    self.prefixString = val
end

---Fall back to the default prefix string setting
function IceCream:ResetPrefix()
    self.prefixString = "ic| "
end

---Disables IceCream execution
function IceCream:IsDisable()
    self.isPrintEnabled = false
end

--- Enables IceCream execution
--- Default: true
function IceCream:IsEnable()
    self.isPrintEnabled = true
end

local IceCreamMate = {}
IceCreamMate = {
    __call = IceCream.IceCreamDebug
}
setmetatable(IceCream, IceCreamMate)


return IceCream
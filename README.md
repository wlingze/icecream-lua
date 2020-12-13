icecream-lua

Never use print() to debug again. (lua)

lua version of [IceCraem](https://github.com/gruns/icecream).

## install

```sh
luarocks install icecream-lua
```

## use

improt module:

```lua
local ic = require("icecream")
```

just use ic() to print information

**The example of printing variables**

```lua
a = 10
ic(a)
local x = 1
local y = 2
ic(x,y)
```

output  `ic| a = 1` and `ic| x = 1, y = 1`

**The exmple of printing function**

```lua
local function fun1(a) 
    return a + 1 
end
ic(fun1(22))
```

output  `ic| fun1(22) = 23`

**The exmple when there are no parameters**

```lua
ic()
```

output: `ic| ` + filename + line + function, like this: `ic| /home/wlz/gh/icecream-lua/main.lua:37: in local 'testNoArg'`

**The exmple when there is no variable name**

```lua
ic(1, 2)
```

output: `ic| 1, 2`

**The exmple of display line munber**

```lua
ic(x,y)
-- ic| x = 1, y = 1
ic:SetIsOutPutPosition(true)
ic(x,y)
-- /home/wlz/gh/icecream-lua/main.lua:11: in local 'testPosition'
-- ic| x = 1, y = 1
```



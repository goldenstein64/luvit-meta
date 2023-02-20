---@meta

---A lua value pretty printer and colorizer for terminals.
local prettyPrint = {}


---Lets you optionally pick a theme, `16` or `256`. Default is no colors or 
---applying a default.
---@param index? 16 | 256
function prettyPrint.loadColors(index) end

---Keeps track of all the colors used in a color theme
---@class luvit.prettyPrint.Theme
---@field property string
---@field sep string
---@field braces string
---@field ["nil"] string
---@field boolean string
---@field number string
---@field string string
---@field quotes string
---@field escape string
---@field ["function"] string
---@field thread string
---@field table string
---@field userdata string
---@field cdata string
---@field err string
---@field success string
---@field failure string
---@field highlight string

---@type luvit.prettyPrint.Theme
prettyPrint.theme = nil

---Works like the default lua print function. We also override the default lua 
---print function.
---@param ... any
function prettyPrint.print(...) end

---@param ... any
function prettyPrint.prettyPrint(...) end

---@param value any
---@param recurse? boolean
---@param nocolor? boolean
---@return string
function prettyPrint.dump(value, recurse, nocolor) end

---Returns the ANSI escape code for `colorName` stored in `prettyPrint.theme`.
---@param colorName? string -- Default is white on black
---@return string
function prettyPrint.color(colorName) end

---Colors `string` with `colorName` and characters afterward with `resetName`.
---Uses `prettyPrint.color` on `colorName` and `resetName`.
---@param colorName? string -- Default is white on black.
---@param string any
---@param resetName? string -- Default is white on black.
---@return string
function prettyPrint.colorize(colorName, string, resetName) end

---@type uv.uv_tty_t | uv.uv_pipe_t
prettyPrint.stdin = nil

---@type uv.uv_tty_t | uv.uv_pipe_t
prettyPrint.stdout = nil

---@type uv.uv_tty_t | uv.uv_pipe_t
prettyPrint.stderr = nil

return prettyPrint
---@meta

---Tiny helper to get os name in luvit.
local los = {}

---@alias luvit.os
---| "win32"
---| "linux"
---| "darwin"
---| "bsd"
---| "posix"
---| "other"

---@return luvit.os
function los.type() end

return los
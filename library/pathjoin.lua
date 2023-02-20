---@meta

---The path utilities that used to be part of luvi
local pathjoin = {}

pathjoin.isWindows = false ---@type boolean

---@param path string
---@return string
function pathjoin.getPrefix(path) end

---@param path string
---@return string[] parts
function pathjoin.splitPath(path) end

---@param prefix? string
---@param parts string[]
---@param i? integer
---@param j? integer
---@return string path
function pathjoin.joinParts(prefix, parts, i, j) end

---@param ... string
---@return string
function pathJoin(...) end

return pathjoin
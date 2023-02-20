---@meta

local utils = {}

---@param fn fun(self: any, ...: any): (...: any)
---@param self any
---@param ... any
---@return fun(...: any): (...: any)
function utils.bind(fn, self, ...) end

---@param err? string
function utils.noop(err) end

---@param continuation function | thread | nil
---@param fn function
---@param ... any
---@return any ...
function utils.adapt(continuation, fn, ...) end

return utils
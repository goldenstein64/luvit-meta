---@meta

local stream_passthrough = {}

---An extension of the `Transform` stream class with the `:_transform()` method 
---declared.
---
---Basically just the most minimal sort of `Transform` stream. Every written 
---chunk gets output as-is.
---@class luvit.stream.PassThrough : luvit.stream.Transform
local PassThrough = {}
stream_passthrough.PassThrough = PassThrough

---@param options luvit.stream.TransformOptions
function PassThrough:initialize(options) end

---@generic obj
---@param self obj
---@param options luvit.stream.TransformOptions
---@return obj
function PassThrough:new(options) end

---@protected
---@param chunk any?
---@param cb fun(err?: string, chunk?: any)
function PassThrough:_transform(chunk, cb) end

return stream_passthrough
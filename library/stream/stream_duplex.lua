---@meta

local stream_duplex = {}

---A `Duplex` stream is both readable and writable and inherits the functionality 
---and methods of `Readable` and `Writable`.
---@class luvit.stream.Duplex : luvit.stream.Readable, luvit.stream.Writable
---@field readable boolean
---@field writable boolean
---@field allowHalfOpen boolean
local Duplex = {}
stream_duplex.Duplex = Duplex

---These options are passed along to the initializers of the readable and 
---writable streams this class uses.
---@class luvit.stream.DuplexOptions : luvit.stream.ReadableOptions, luvit.stream.WritableOptions
---@field readable boolean
---@field writable boolean
---@field allowHalfOpen boolean

---@param options luvit.stream.DuplexOptions
function Duplex:initialize(options) end

---@generic obj
---@param self obj
---@param options luvit.stream.DuplexOptions
---@return obj
function Duplex:new(options) end

return stream_duplex
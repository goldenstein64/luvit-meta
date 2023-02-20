---@meta

local stream_core = {}

---This is the stream core or base. Extends the `luvit.Emitter`.
---
---You will most likely not use this class. The only relevant part of this 
---class, the `:pipe()` method, is overridden in `luvit.stream.Readable`.
---@class luvit.stream.Stream : luvit.Emitter
local Stream = {}
stream_core.Stream = Stream

---@class luvit.stream.StreamOptions
---@field _end boolean

---@generic obj
---@param self obj
---@return obj
function Stream:new() end

---@param dest luvit.stream.Stream
---@param options luvit.stream.StreamOptions
---@return luvit.stream.Stream dest
function Stream:pipe(dest, options) end

return stream_core
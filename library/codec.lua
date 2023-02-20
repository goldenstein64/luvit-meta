---@meta
---Utilities for working with luvit streams and codecs.
local codec = {}

---Wraps an emitter with coroutines. Returns read and write functions.
---@param emitter any
---@return function read, function write
function codec.wrapEmitter(emitter) end

---Given a raw uv_stream_t userdata, return coro-friendly read/write functions.
---@param socket any
---@return function read, function write
function codec.wrapStream(socket) end

---Allows one to chain coroutines
---@param ... any
function codec.chain(...) end

return codec
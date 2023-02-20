---@meta

local stream_writable = {}

---The `Writable` stream class.
---
---Emits `end` when done.
---@class luvit.stream.Writable : luvit.stream.Stream
---@field protected _writableState luvit.stream.WritableState
local Writable = {}
stream_writable.Writable = Writable

---Used internally by `stream.Writable`, suspected to describe a `WriteRequest`.
---@class luvit.stream.WriteReq : luvit.Object
---@field chunk string|string[]
---@field cb fun(err?: string|luvit.Error, ...: any)
local WriteReq = {}
stream_writable.WriteReq = WriteReq

---@param chunk string|string[]
---@param cb fun(err?: string|luvit.Error, ...: any)
function WriteReq:initialize(chunk, cb) end

---@generic obj
---@param self obj
---@param chunk string|string[]
---@param cb fun(err?: string|luvit.Error, ...: any)
---@return obj
function WriteReq:new(chunk, cb) end

---@class luvit.stream.WritableOptions
---@field objectMode boolean -- `true` if this writable accepts objects, `false` if it only accepts raw strings.
---@field writableObjectMode boolean -- Pertains to whether Duplex objects accept objects or not.
---@field highWaterMark integer -- Determines when this `Writable` requires a `"drain"` event. 

---Used internally within the `Writable` class to hold state.
---@class luvit.stream.WritableState
---@field objectMode boolean
---@field highWaterMark integer
---@field needDrain boolean
---@field ending boolean
---@field ended boolean
---@field finished boolean
---@field length integer
---@field writing boolean
---@field corked integer
---@field sync boolean
---@field bufferProcessing boolean
---@field onwrite fun(stream: luvit.stream.Stream, err: string?)
---@field writecb fun(chunk: string|string[], encoding: string, cb: fun(err: string?))?
local WritableState = {}
stream_writable.WritableState = WritableState

---@param options luvit.stream.WritableOptions
---@param stream luvit.stream.Stream
function WritableState:initialize(options, stream) end

---@generic obj
---@param self obj
---@param options luvit.stream.WritableOptions
---@param stream luvit.stream.Stream
---@return obj
function WritableState:new(options, stream) end

---@param options luvit.stream.WritableOptions
function Writable:initialize(options) end

---@generic obj
---@param self obj
---@param options luvit.stream.WritableOptions
---@return obj
function Writable:new(options) end

---@deprecated Writables are not pipeable
function Writable:pipe() end

---Manually write a chunk.
---@param chunk string | any? -- The data to write. Changes based on `objectMode`.
---@param cb fun(err?: string)? -- called when this task is finished.
---@return boolean -- `false` when it needs draining, `true` otherwise.
function Writable:write(chunk, cb) end

---Kind of like pause.
---
---Stop writing any buffered data. Any number of `:cork()` calls requires an 
---equal number of `:uncork()` calls to keep writing.
function Writable:cork() end

---Kind of like resume.
---
---Continue writing any buffered data. Any number of `:cork()` calls requires
---an equal number of `:uncork()` calls to keep writing.
function Writable:uncork() end

---@protected
---Errors by default, make sure to implement in a sub-class.
function Writable:_write(chunk, cb) end

---Not quite sure what this is for.
---@type fun(chunk: string | any?, cb: fun(err?: string)?)
Writable._writev = nil

---@param chunk string | any?
---@param cb fun()?
function Writable:_end(chunk, cb) end

return stream_writable
---@meta
local stream_transform = {}

---A transform stream is a readable/writable stream where you do
---something with the data.  Sometimes it's called a "filter",
---but that's not a great name for it, since that implies a thing where
---some bits pass through, and others are simply ignored.  (That would
---be a valid example of a transform, of course.)
---
---While the output is causally related to the input, it's not a
---necessarily symmetric or synchronous transformation.  For example,
---a zlib stream might take multiple plain-text `write()` calls, and then
---emit a single compressed chunk some time in the future.
---
---Here's how this works:
---
---The Transform stream has all the aspects of the readable and writable
---stream classes.  When you `write(chunk)`, that calls `_write(chunk, cb)`
---internally, and returns `false` if there's a lot of pending writes
---buffered up.  When you call `read()`, that calls `_read(n)` until
---there's enough pending readable data buffered up.
---
---In a transform stream, the written data is placed in a buffer.  When
---`_read(n)` is called, it transforms the queued up data, calling the
---buffered `_write` `cb`'s as it consumes chunks.  If consuming a single
---written chunk would result in multiple output chunks, then the first
---outputted bit calls the `readcb`, and subsequent chunks just go into
---the read buffer, and will cause it to emit `'readable'` if necessary.
---
---This way, back-pressure is actually determined by the reading side,
---since `_read` has to be called to start processing a new chunk.  However,
---a pathological inflate type of transform can cause excessive buffering
---here.  For example, imagine a stream where every byte of input is
---interpreted as an integer from 0-255, and then results in that many
---bytes of output.  Writing the 4 bytes `{ff, ff, ff, ff}` would result in
---1kb of data being output.  In this case, you could write a very small
---amount of input, and end up with a very large amount of output.  In
---such a pathological inflating mechanism, there'd be no way to tell
---the system to stop doing the transform.  A single 4MB write could
---cause the system to run out of memory.
---
---However, even in such a pathological case, only a single written chunk
---would be consumed, and then the rest would wait (un-transformed) until
---the results of the previous transformed chunk were consumed.
---@class luvit.stream.Transform : luvit.stream.Duplex
---@field protected _transformState luvit.stream.TransformState
local Transform = {}
stream_transform.Transform = Transform

---@class luvit.stream.TransformState : luvit.Object
local TransformState = {}

---@class luvit.stream.TransformOptions : luvit.stream.DuplexOptions

---@param options luvit.stream.TransformOptions
---@param stream luvit.stream.Transform
function TransformState:initialize(options, stream) end

---@generic obj
---@param self obj
---@param options luvit.stream.TransformOptions
---@param stream luvit.stream.Transform
---@return obj
function TransformState:new(options, stream) end

---Extendable initializer for the Transform class.
---@param options luvit.stream.TransformOptions
function Transform:initialize(options) end

---@generic obj
---@param self obj
---@param options luvit.stream.TransformOptions
---@return obj
function Transform:new(options) end

---@protected
---The internal transform method. You must define this in your child class. 
---E.g. implement a passthrough filter a.k.a. a very fancy way to print hello 
---world
---
---```lua
---do
---  local Transform = require('stream').Transform
---  local Transformer = Transform:extend()
---  function Transformer:initialize()
---    Transform.initialize(self, {objectMode = true})
---  end
---  
---  function Transformer:_transform(line, cb)
---    self:push(line)
---    return cb()
---  end
---  
---  local transformer = Transformer:new()
---  transformer:on('data', print)
---  transformer:write('hello world')
---end
---```
---@param chunk? any
---@param cb fun(err?: string, data?: any)
function Transform:_transform(chunk, cb) end

return stream_transform
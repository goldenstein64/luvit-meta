---@meta

local stream_readable = {}

---Used to hold state by the `stream.Readable` class
---@class luvit.stream.ReadableState : luvit.Object
---@field highWaterMark integer
---@field buffer (string|string[])[]
---@field length integer
---@field pipes luvit.stream.Stream?
---@field pipesCount integer
---@field flowing luvit.stream.Stream?
---@field ended boolean
---@field endEmitted boolean
---@field reading boolean
---a flag to be able to tell if the `onwrite` callback is called immediately,
---or on a later tick.
---@field sync boolean
---whenever we return null, then we set a flag to say
---that we're awaiting a 'readable' event emission.
---@field needReadable boolean
---@field emittedReadable boolean
---@field readableListening boolean
---@field objectMode boolean
---when piping, we only care about 'readable' events that happen
---after `read()`ing all the bytes and not getting any pushback.
---@field ranOut boolean
---the number of writers that are awaiting a drain event in `:pipe()`s
---@field awaitDrain integer
---if true, a `maybeReadMore` (internal function) has been scheduled
---@field readingMore boolean
local ReadableState = {}
stream_readable.ReadableState = ReadableState

---@class luvit.stream.ReadableOptions
---The point at which it stops calling `Readable:_read()` to fill the buffer. 
---Note: `0` is a valid value, which means "don't call _read preemptively ever"
---
---Defaults to 16, maxes out at 128MB. 
---128MB limit cannot be overwritten without modifying 
---`luvit/deps/stream/stream_readable.lua`
---@field highWaterMark integer?
---object stream flag. Used to make `Readable:read(n)` ignore `n` and to make 
---all the buffer merging and length checks go away
---
---If `false`/`nil` then `options.highWaterMark` is set to 16 * 1024
---@field objectMode boolean?
---Used only if the `stream` argument is an instance of `stream.Duplex`, and is 
---behaves like `objectMode`.
---@field readableObjectMode boolean?

---@param options? luvit.stream.ReadableOptions
---@param stream luvit.stream.Stream
function ReadableState:initialize(options, stream) end

---@generic obj
---@param self obj
---@param options? luvit.stream.ReadableOptions
---@param stream luvit.stream.Stream
---@return obj
function ReadableState:new(options, stream) end

---Extends `luvit.stream.Stream`, implements a readable stream interface. Uses 
---`ReadableState` to keep track of `self._readableState`.
---@class luvit.stream.Readable : luvit.stream.Stream
---@field protected _readableState luvit.stream.ReadableState
local Readable = {}
stream_readable.Readable = Readable

---@param options? luvit.stream.ReadableOptions
function Readable:initialize(options) end

---@generic obj
---@param self obj
---@param options? luvit.stream.ReadableOptions
---@return obj
function Readable:new(options) end

---Manually shove something into the read buffer. This returns `true` if the 
---`highWaterMark` has not been hit yet, similar to how `Writable:write()` 
---returns `true` if you should `write()` some more.
---@param chunk string|string[]
---@return boolean
function Readable:push(chunk) end

---Pushes a chunk of data into the internal buffer.
---
---Unshift should *always* be something directly out of `Readable:read()`.
---@param chunk string|string[]
---@return boolean
function Readable:unshift(chunk) end

---Reads and returns `n` chunk bytes
---@param n integer -- the number of bytes to read
---@return string|string[] chunk
function Readable:read(n) end

---@protected
---Internal method executed by `Readable:read()`. Can be overwritten in child 
---classes.
---@param n integer
function Readable:_read(n) end

---@class luvit.stream.ReadablePipeOptions
---@field _end boolean

---Attaches a `Writable` stream, causing it to switch automatically into 
---flowing mode and push all of its data to the attached `Writable`.
---@param dest luvit.stream.Writable
---@param pipeOpts? luvit.stream.ReadablePipeOptions
---@return luvit.stream.Writable dest
function Readable:pipe(dest, pipeOpts) end

---Removes pipes to `dest`.
---@generic self
---@param self self
---@param dest luvit.stream.Writable
---@return self
function Readable:unpipe(dest) end

---Triggers `callback` when `event` is triggered. E.g.
---
---```lua
---do
---  local child = require('stream').Readable
---  child:on('foo', function() print('bar') end)
---  child:emit('foo') --> 'bar'
---
---  child:on('bar', function(data) print(data) end)
---  child:emit('bar', 'foo') --> 'foo'
---end
---```
---@generic self
---@param self self
---@param event string
---@param callback fun(...: any)
---@return self
function Readable:on(event, callback) end

---Alias for `stream.Readable:on()`.
---
---You can use `Readable:addListener(...)` for an implicit self or use 
---`Readable.addListener(self, ...)`.
---@generic self
---@param self self
---@param event string
---@param callback fun(...: any)
---@return self
function Readable:addListener(event, callback) end

---Resumes a stream.
function Readable:resume() end

---Pauses a stream.
function Readable:pause() end

---Wrap a `Stream` as the async data source.
---@generic self
---@param self self
---@param stream luvit.stream.Stream
---@return self
---@deprecated
function Readable:wrap(stream) end

return stream_readable
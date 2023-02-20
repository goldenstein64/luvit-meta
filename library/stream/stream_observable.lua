---@meta

local stream_observable = {}

---@class luvit.stream.ObservableOptions : luvit.stream.TransformOptions

---Observable is a stream that can be observed outside the pipeline. 
---`:observe()` returns a new `Readable` stream that emits all data that passes 
---through this stream. Streams created by `observe()` do not affect 
---back-pressure.
---@class luvit.stream.Observable : luvit.stream.Transform
---@field options luvit.stream.ObservableOptions
---@field observers luvit.stream.Readable[]
local Observable = {}
stream_observable.Observable = Observable

---@param options luvit.stream.ObservableOptions
function Observable:initialize(options) end

---@generic obj
---@param self obj
---@param options luvit.stream.ObservableOptions 
---@return obj
function Observable:new(options) end

---Returns a new `Readable` stream that emits all data that passes through this 
---stream. Streams created by `observe()` do not affect back-pressure.
---@return luvit.stream.Readable
function Observable:observe() end

return stream_observable
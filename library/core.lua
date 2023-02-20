---@meta
---Core object model for luvit using simple prototypes and inheritance. We 
---support single inheritance for classes.
local core = {}

---Given an object and a class, returns whether 
---the object is an instance of that class.
---@param obj any
---@param class any
---@return boolean
---
---```lua
---do
---  local em = core.Emitter:new()
---  core.instanceof(em, core.Emitter) --> true
---end
---```
function core.instanceof(obj, class) end

---The base object class. It provides simple prototypal inheritance and 
---inheritable constructors. All other objects inherit from this.
---@class luvit.Object
---@field meta table -- contains the object's metamethods
local Object = {}
core.Object = Object

---Create a new instance of this object
---@generic obj
---@return obj
function Object:create() end

---Creates a new instance and calls `obj:initialize(...)` if it exists.
---@generic obj
---@param ... any
---@return obj
---
---```lua
---do
---  local Rectangle = Object:extend()
---  function Rectangle:initialize(w, h)
---    self.w = w
---  	 self.h = h
---  end
---  function Rectangle:getArea()
---    return self.w * self.h
---  end
---  local rect = Rectangle:new(3, 4)
---  print(rect:getArea())
---end
---```
function Object:new(...) end

---Creates a new sub-class.
---
---```lua
---do
---  local Square = Rectangle:extend()
---  function Square:initialize(w)
---    self.w = w
---    self.h = h
---  end
---end
---```
function Object:extend() end

---This class can be used directly whenever an event emitter is needed.
---
---```lua
---do
---  local emitter = Emitter:new()
---  emitter:on('foo', p)
---  emitter:emit('foo', 1, 2, 3)
---end
---```
---
---Also it can easily be sub-classed.
---
---```lua
---do
---  local Custom = Emitter:extend()
---  local c = Custom:new()
---  c:on('bar', onBar)
---end
---```
---
---Unlike EventEmitter in node.js, Emitter class doesn't auto bind `self`
---reference. This means, if a callback handler is expecting a `self` reference,
---utils.bind() should be used, and the callback handler should have a `self` at
---the beginning its parameter list.
---
---```lua
---do
---  function some_func(self, a, b, c) end
---  emitter:on('end', utils.bind(some_func, emitter))
---  emitter:emit('end', 'a', 'b', 'c')
---end
---```
---@class luvit.Emitter : luvit.Object 
local Emitter = {}
core.Emitter = Emitter

---@generic obj
---@param self obj
---@return obj
function Emitter:new() end

---By default, any error events that are not listened for should throw errors
---@param name string
---@param ... any
function Emitter:missingHandlerType(name, ...) end

---Same as `Emitter:on` except it de-registers itself after the first event.
---@generic self
---@param self self
---@param name string
---@param callback function
---@return self
---
---```lua
---do
---  local e1 = Emitter:new()
---  local cnt = 0
---  local function incr()
---    cnt = cnt + 1
---  end
---  local function dummy()
---    assert(false, "this should be removed and never fire")
---  end
---  
---  e1:once('t1', incr)
---  e1:once('t1', dummy)
---  e1:once('t1', incr)
---  e1:removeListener('t1', dummy)
---  e1:emit('t1')
---  
---  assert(cnt == 2)
---  assert(e1:listenerCount('t1') == 0)
---end
---```
function Emitter:once(name, callback) end

---Adds an event listener (`callback`) for the named event `name`.
---@generic self
---@param self self
---@param name string
---@param callback function
---@return self
function Emitter:on(name, callback) end

---```lua
---do
---  assert(2 == Emitter:new()
---    :on("foo", function(a) end)
---    :on("foo", function(a,b) end)
---    :on("bar", function(a,b) end)
---    :listenerCount("foo"))
---
---  assert(0 == Emitter:new():listenerCount("non-exist"))
---end
---```
---@param name string
---@return integer
function Emitter:listenerCount(name) end

---Emit a named event to all listeners with optional data argument(s).
---@generic self
---@param self self
---@param name string
---@param ... any
---@return self
function Emitter:emit(name, ...) end

---Removes a listener so that it no longer catches events.
---Returns the number of listeners removed, or nil if none were removed
---@param name string
---@param callback? function
---@return integer?
---
---```lua
---do
---  local em = Emitter:new()
---  em:on('data', function(data) print(data) end)
---  em:emit('data', 'foo') --> foo
---  em:removeListener('data', function() em:emit('data', 'foo') end)
---  --> nothing printed
---end
---```
---
---```lua
---do
---  local e1 = Emitter:new()
---  local cnt = 0
---  local function incr()
---    cnt = cnt + 1
---  end
---  local function dummy()
---    assert(false, "this should be removed and never fire")
---  end
---  e1:on('t1', incr)
---  e1:on('t1', dummy)
---  e1:on('t1', incr)
---  e1:removeListener('t1', dummy)
---  e1:emit('t1')
---  assert(cnt == 2)
---  assert(e1:listenerCount('t1') == 2)
---end
---```
function Emitter:removeListener(name, callback) end

---Remove all listeners
---
---```lua
---do
---  local em = require('core').Emitter:new()
---  assert(#em:listeners('data') == 0)
---  
---  em:on('data', function() end)
---  em:removeAllListeners()
---  
---  em:on('data', expect(function() end))
---  em:emit('data', 'Go Fish')
---  
---  em:on('event', function() end)
---  em:on('event', function() end)
---  
---  assert(em:listenerCount('data') == 1)
---  assert(em:listenerCount('event') == 2)
---  assert(em:listenerCount('data')  == #em:listeners('data'))
---  assert(em:listenerCount('event') == #em:listeners('event'))
---  
---  em:removeAllListeners('data')
---  
---  assert(em:listenerCount('data') == 0)
---  assert(em:listenerCount('event') == 2)
---  
---  em:removeAllListeners('unused_listener')
---  
---  assert(em:listenerCount('data') == 0)
---  assert(em:listenerCount('event') == 2)
---  
---  em:removeAllListeners()
---  
---  assert(em:listenerCount('data') == 0)
---  assert(em:listenerCount('event') == 0)
---  assert(em:listenerCount('data')  == #em:listeners('data'))
---  assert(em:listenerCount('event') == #em:listeners('event'))
---end
---```
---
---@param name string? -- optional event name
function Emitter:removeAllListeners(name) end

---Get listeners
---@param name string -- event name
---@return function[]
---@overload fun(): { [string]: function[] }
function Emitter:listeners(name) end

---Utility that binds the named method `self[name]` for use as a callback. The
---first argument (`err`) is re-routed to the "error" event instead.
---@param name string
---
---```lua
---do
---  local Joystick = Emitter:extend()
---  function Joystick:initialize(device)
---    self:wrap("onOpen")
---    fs.open(device, self.onOpen)
---  end
---  function Joystick:onOpen(fd)
---    -- and so forth
---  end
---end
---```
function Emitter:wrap(name) end

---Propagate the event to another emitter.
---@generic self
---@param self self
---@param eventName string
---@param target luvit.Emitter
---@return self
function Emitter:propagate(eventName, target) end

---This is for code that wants structured error messages.
---@class luvit.Error : luvit.Object
---@field message string?
---@field code integer? -- result of `Error.message:match("([^:]+): ")`
local Error = {}

---@generic obj
---@param self obj
---@param message? string
---@return obj
function Error:new(message) end

---@param message? string
function Error:initialize(message) end

return core
---@meta

---
---Core object model for luvit using simple prototypes and inheritance.
---
---This module is for various classes and utilities that don't need their own module.
local core = {}

---
---Returns whether `obj` is instance of `class` or not.
---@param obj Object   # An instance of some class
---@param class Object # The class to compare against
---@return boolean
function core.instanceof(obj, class) end


---
---This is the most basic object in Luvit. It provides simple prototypal
-- inheritance and inheritable constructors. All other objects inherit from this.
---
---@class Object
---@field meta table # A table value holding all metatables that will be applied on Object:create()
local Object = {}
core.Object = Object

-- Create a new instance of this object
---@generic T: Object
---@param self T
---@return T instance # The created instance
function Object:create() end

---
---Creates a new instance and calls `obj:initialize(...)` if it exists.
---
---An example:
---```lua
---local Rectangle = Object:extend()
---function Rectangle:initialize(w, h)
---   self.w = w
---   self.h = h
---end
---function Rectangle:getArea()
---   return self.w * self.h
---end
---local rect = Rectangle:new(3, 4)
---p(rect:getArea())
---```
---
---@generic T
---@param self T
---@param ... any
---@return T instance # The newly created instance
function Object:new(...) end

-- FIXME: Object:extend() return does not contain all properties -
-- FIXME: `self` inside Object:extend() is not recognized as an Object

---
---Creates a new sub-class.
---
---An example:
---```lua
---local Square = Rectangle:extend()
---function Square:initialize(w)
---  self.w = w
---  self.h = h
---end
---```
---
---@generic T: Object
---@param self T
---@return T
function Object:extend()
  self.meta = {
    super = self
  }
  return self
end

---
---This class can be used directly whenever an event emitter is needed.
---
---An example:
---```lua
---local emitter = Emitter:new()
---emitter:on('foo', p)
---emitter:emit('foo', 1, 2, 3)
---```
---
---Also it can easily be sub-classed.
---
---```lua
---local Custom = Emitter:extend()
---local c = Custom:new()
---c:on('bar', onBar)
---```
---
---Unlike EventEmitter in node.js, Emitter class doesn't auto binds `self`
---reference. This means, if a callback handler is expecting a `self` reference,
---utils.bind() should be used, and the callback handler should have a `self` at
---the beginning its parameter list.
---
---```lua
---function some_func(self, a, b, c) end
---emitter:on('end', utils.bind(some_func, emitter))
---emitter:emit('end', 'a', 'b', 'c')
---```
---
---@class Emitter: Object
---@field handlers? table<string, function[]>     # A map of `event_name = listeners`, where listeners is an array of callbacks.
---@field addHandlerType? fun(event_name: string) # When assigned, the function value is called just before assigning `handlers[event_name] = {}`.
local Emitter = Object:extend()
core.Emitter = Emitter

---
---If `name` is `"error"`, and `process` has an event handler for error, fire an `error` event on the process handler.
---
---This is mostly just for internal use.
---
---@param name? "error"|string
---@param ... any
function Emitter:missingHandlerType(name, ...) end

---
---Same as `Emitter:on` except it de-registers itself after the first event.
---
---@generic T: Emitter
---@param self T
---@param name string            # The event name to listen on
---@param callback fun(...: any) # The callback to execute on event fire
---@return T self
function Emitter:once(name, callback) end

---
---Adds an event listener `callback` for the named event `name`.
---`callback` will receive whatever `Emitter:emit` passes as arguments.
---
---@generic T: Emitter
---@param self T
---@param name string            # The event name to listen on
---@param callback fun(...: any) # The callback to execute on event fire
---@return T self
function Emitter:on(name, callback) end

---
---Returns how many listener is currently assigned for event `name`.
---
---@overload fun(): 0
---@param name string
---@return number count
function Emitter:listenerCount(name) end

---
---Emit a named event to all listeners with optional data argument(s).
---
---@generic T: Emitter
---@param self T
---@param name string
---@param ... any
---@return T self
function Emitter:emit(name, ...) end

---
---Remove a listener so that it no longer catches events.
---Returns the number of listeners removed, or nil if none were removed.
---
---@param name string       # The event name of which the listener belongs to
---@param callback function # The callback of the listener you want to remove
---@return number|nil count # How many argument removed, if any
function Emitter:removeListener(name, callback) end

---
---If no `name` is provided, remove all listeners for all events, otherwise remove all listeners for provided event.
---
---@param name? string # optional event name
function Emitter:removeAllListeners(name) end

---
---Get all listeners for `name` event.
---
---@param name string # The event's name
---@return function[] # An array of callbacks
function Emitter:listeners(name) end

---
---Utility that binds the named method `self[name]` for use as a callback.
---The first argument `err` is re-routed to the "error" event instead.
---
---An example:
---```lua
---local Joystick = Emitter:extend()
---function Joystick:initialize(device)
---  self:wrap("onOpen")
---  FS.open(device, self.onOpen)
---end
---
---function Joystick:onOpen(fd)
---  -- and so forth
---end
---```
---@param name any
function Emitter:wrap(name) end

---
---Propagate the event to another emitter.
---That is, it emits `eventName` on `target` Emitter whenever the same event is fired on current the instance.
---
---@param eventName string
---@param target Emitter
function Emitter:propagate(eventName, target) end

--[[ Error class ]]

---
---This is for code that wants structured error messages.
---
---@class Error: Object
---@field message? string # The error message
---@field code? number    # The error code. This is available if message is formated as `404: Not Found`.
local Error = Object:extend()
core.Error = Error

---
---Make errors tostringable.
---
---@param table Error
---@return string message
function Error.meta.__tostring(table) end

---
---**NOT** for end-users. Please use `Error:new(message)` instead of this.
---Initialize a new Error instance.
---
---@param message? string # The error message
function Error:initialize(message) end

return core

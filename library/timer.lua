---@meta

---Javascript style setTimeout and setInterval for luvit
local timer = {}

---@param delay integer -- in milliseconds
---@param thread? thread
function timer.sleep(delay, thread) end

---Calls `callback(...)` once after `delay` milliseconds.
---@param delay integer -- in milliseconds
---@param callback function
---@param ... any -- arguments passed to `callback`
---@return uv.uv_timer_t
function timer.setTimeout(delay, callback, ...) end

---Calls `callback(...)` repeatedly after every `interval` milliseconds.
---@param interval integer -- in milliseconds
---@param callback function
---@param ... any -- arguments passed to `callback`
---@return uv.uv_timer_t
function timer.setInterval(interval, callback, ...) end

---Stops a timer started by `timer.setInterval`.
---@param timer uv.uv_timer_t
function timer.clearInterval(timer) end

---Stops a timer started by `timer.setTimeout`. Alias for `timer.clearInterval`.
---@param timer uv.uv_timer_t
function timer.clearTimeout(timer) end

---@deprecated -- use timer.clearInterval or timer.clearTimeout
---Stops a timer. Alias for `timer.clearInterval`.
---@param timer uv.uv_timer_t
function timer.clearTimer(timer) end

---Calls `callback(...)` on the next `libuv` loop iteration.
---@param callback function
---@param ... any -- arguments to `callback`
function timer.setImmediate(callback, ...) end

---Makes `item` emit `"timeout"` after `msecs` milliseconds.
---The timeout cannot run until it is marked as active with `timer.active()`.
---@param item table
---@param msecs integer -- in milliseconds
function timer.enroll(item, msecs) end

---Removes any possible emissions of `"timeout"`.
---@param item table
function timer.unenroll(item) end

---Marks `item` as ready to emit a `"timeout"`. Only effective after calling
---`timer.enroll(item, msecs)`.
---@param item table
function timer.active(item) end

return timer
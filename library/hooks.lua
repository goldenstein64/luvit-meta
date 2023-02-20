---Hooks are intended to be a global event emitter for internal Luvit events. 
---For example, `process.exit` and signals can feed through this emitter.
---@class luvit.Hooks : luvit.Emitter
local hooks = {}

return hooks
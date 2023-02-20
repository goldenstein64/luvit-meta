---@meta
---It is possible to stream data through a child's stdin, stdout, and stderr 
---in a fully non-blocking way.
local childprocess = {}

---@class luvit.childprocess.SpawnOptions
---@field detached? boolean
---@field stdio? { [1]: luvit.Emitter?, [2]: luvit.Emitter?, [3]: luvit.Emitter? }
---@field cwd? string
---@field uid? integer
---@field gid? integer

---@class luvit.childprocess.ChildProcess : luvit.Emitter
---@field stdin luvit.net.Socket
---@field stdout luvit.net.Socket
---@field stderr luvit.net.Socket
---@field handle uv.uv_handle_t
---@field pid integer
---@field exitCode integer?
---@field signal string
local ChildProcess = {}

---@generic self
---@param self self
---@param stdin luvit.Emitter
---@param stdout luvit.Emitter
---@param stderr luvit.Emitter
---@return self
function ChildProcess:new(stdin, stdout, stderr) end

---@param stdin luvit.Emitter
---@param stdout luvit.Emitter
---@param stderr luvit.Emitter
function ChildProcess:initialize(stdin, stdout, stderr) end

---@param handle luvit.uv.Handle
function ChildProcess:setHandle(handle) end

---@param pid integer
function ChildProcess:setPid(pid) end

---@param signal? string -- default is `"sigterm"`
function ChildProcess:kill(signal) end

---@param err? string
function ChildProcess:close(err) end

---@param err? string
function ChildProcess:destroy(err) end

---Spawns a command line process.
---
---Since the data coming in is a stream, you may want to pass it through a 
---filter like the luvit `line-emitter` package to get lines instead.
---@param command string
---@param args string[]
---@param options luvit.childprocess.SpawnOptions
---@return luvit.childprocess.ChildProcess
function childprocess.spawn(command, args, options) end

---@class luvit.childprocess.ExecOptions : luvit.childprocess.SpawnOptions
---@field timeout number
---@field maxBuffer integer -- Default = `4 * 1024`
---@field signal string -- Default = `'SIGTERM'`
---@field shell string -- Default = `'cmd.exe'` or `'/bin/sh'`

---Executes the supplied `command` and returns data returned in the `callback`.
---The `callback` can be either a function or a thread for coroutine style 
---code. The `command` can have arguments e.g. 
---`childprocess.exec('ls -a', print)`.
---@param command string
---@param options luvit.childprocess.ExecOptions
---@param callback function
---@overload fun(command: string, callback: function)
function childprocess.exec(command, options, callback) end

---Similiar to `childprocess.exec` but the arguments for the command/file must 
---be supplied as a string to the second parameter. Also, callback is optional 
---as well here.
---@param file string
---@param args? string[]
---@param options? luvit.childprocess.ExecOptions
---@param callback function|thread
---@overload fun(file: string)
---@overload fun(file: string, callback: function|thread)
---@overload fun(file: string, args?: string, callback: function|thread)
function childprocess.execFile(file, args, options, callback) end

return childprocess
---@meta

---Node-style net client and server module for luvit
local net = {}

---@class luvit.net.Socket : luvit.stream.Duplex
---@field protected _handle? uv.uv_stream_t
---@field protected _connecting boolean
---@field protected _reading boolean
---@field protected _destroyed boolean
---@operator call(number | luvit.net.SocketOptions?): luvit.net.Socket
local Socket = {}
net.Socket = Socket

---@class luvit.net.SocketOptions
---@field handle? uv.uv_stream_t
---@field fd? integer

---@param options number | luvit.net.SocketOptions?
function Socket:initialize(options) end

---@generic obj
---@param self obj
---@param options number | luvit.net.SocketOptions?
---@return obj
function Socket:new(options) end

---@protected
function Socket:_onSocketFinish() end

---@protected
function Socket:_onSocketEnd() end

---Bind the socket to a host and port.
---
---Use a port of `0` to let the OS assign an ephemeral port. You can look it up 
---later using `Socket:getsockname()`.
---@param ip string
---@param port string | integer
function Socket:bind(ip, port) end

---Get the address of the peer connected to this socket.
---@return uv.socketinfo?, string? error, string? errorName
function Socket:address() end

---@param msecs number
---@param callback? fun()
function Socket:setTimeout(msecs, callback) end

---@protected
---@param data string | string[]
---@param callback fun(err?: string) 
function Socket:_write(data, callback) end

---@protected
---@param n integer
function Socket:_read(n) end

---Shutdown the outgoing (write) side of this socket. `callback` is called 
---after shutdown is complete.
---@param callback? fun(err?: string)
function Socket:shutdown(callback) end

---Enable/disable Nagle's algorithm.
---@param enable boolean
function Socket:nodelay(enable) end

---Enable/disable TCP keep-alive.
---@param enable boolean
---@param delay? integer -- Initial delay in seconds, ignored when `enable` is `false`.
function Socket:keepalive(enable, delay) end

---Gets the size of the send buffer that the operating system uses for the 
---socket.
---
---Note: Linux will return double the size of the original set value.
---@return integer? sendBufferSize, string? error, string? errorName
function Socket:getSendBufferSize() end

---Gets the size of the receive buffer that the operating system uses for the 
---socket.
---
---Note: Linux will return double the size of the original set value.
---@return integer? recvBufferSize, string? error, string? errorName
function Socket:getRecvBufferSize() end

---Sets the size of the send buffer that the operating system uses for the 
---socket.
---
---Note: Linux will set double the size of the original set value.
---@param size number
---@return 0?, string? error, string? errorName
function Socket:setSendBufferSize(size) end

---Sets the size of the receive buffer that the operating system uses for the 
---socket.
---
---Note: Linux will set double the size of the original set value.
---@param size number
---@return 0?, string? error, string? errorName
function Socket:setRecvBufferSize(size) end

---Stop reading data from the socket. This function is idempotent and may be 
---safely called on a stopped stream.
function Socket:pause() end

---Resume reading data from the socket.
function Socket:resume() end

---@class luvit.socket.ConnectOptions
---@field port string
---@field host? string

---Returns `self` on success, `nil` and emits `'error'` on failure
---@param port string
---@param host string
---@param callback? fun()
---@return self? self
---@overload fun(self: luvit.net.Socket, options: luvit.socket.ConnectOptions, callback?: fun()): (self: luvit.net.Socket?)
---@overload fun(self: luvit.net.Socket, port: string, callback?: fun()): (self: luvit.net.Socket?)
function Socket:connect(port, host, callback) end

---@param exception? string
---@param callback? fun()
function Socket:destroy(exception, callback) end

---@param queueSize integer -- Default is `128`.
function Socket:listen(queueSize) end

---Get the current address to which this socket is bound.
---@return uv.socketinfo?, string? error, string? errorName
function Socket:getsockname() end

---@class luvit.net.Server : luvit.Emitter
---@operator call: luvit.net.Server
local Server = {}
net.Server = Server

---@class luvit.net.ServerOptions
---@field handle? luvit.net.Socket

---@param options luvit.net.ServerOptions
---@param connectionListener fun(client: luvit.net.Socket)
function Server:init(options, connectionListener) end

---@param err? string
---@param callback? fun()
function Server:destroy(err, callback) end

---@param port string
---@param ip? string
---@param callback? fun()
---@return self
---@overload fun(self: luvit.net.Server, port: string, callback?: fun()): luvit.net.Server
function Server:listen(port, ip, callback) end

---Returns nothing if no handle is set.
---@return uv.socketinfo?, string? error, string? errorName
function Server:address() end

---@param callback fun()
function Server:close(callback) end

---@param port string
---@param host string
---@param callback? fun()
---@return luvit.net.Socket
---@overload fun(options: luvit.net.SocketOptions, callback?: fun()): luvit.net.Socket
---@overload fun(port: string, callback?: fun()): luvit.net.Socket
function net.createConnection(port, host, callback) end

---@param port string
---@param host string
---@param callback? fun()
---@return luvit.net.Socket
---@overload fun(options: luvit.net.SocketOptions, callback?: fun()): luvit.net.Socket
---@overload fun(port: string, callback?: fun()): luvit.net.Socket
function net.connect(port, host, callback) end

---@param options luvit.net.ServerOptions
---@param connectionListener fun(client: luvit.net.Socket)
---@return luvit.net.Server
function net.createServer(options, connectionListener) end

return net
---@meta

---Node-style udp module for luvit
---
---Example:
---
---```lua
---do
---  local PORT, HOST, s1, s2
---  local onMessageS1, onMessageS2, onError
---  
---  HOST = '127.0.0.1'
---  PORT = 53211
---  
---  s1 = dgram.createSocket()
---  s2 = dgram.createSocket()
---  
---  function onMessageS1(msg, rinfo)
---    assert(#msg == 4)
---    assert(msg == 'PING')
---    s1:send('PONG', PORT+1, HOST)
---  end
---  
---  function onMessageS2(msg, rinfo)
---    assert(#msg == 4)
---    assert(msg == 'PONG')
---    s1:close()
---    s2:close()
---  end
---  
---  function onError(err)
---    assert(err)
---  end
---  
---  s1:on('message', expect(onMessageS1))
---  s1:on('error', onError)
---  s1:bind(PORT,'127.0.0.1')
---  
---  s2:on('message', expect(onMessageS2))
---  s2:on('error', onError)
---  s2:bind(PORT+1, '127.0.0.1')
---  s2:send('PING', PORT, HOST)
---end
---```
---
---Multicasting Example:
---
---```lua
---do
---  local PORT = process.env.PORT or 10081
---  local HOST = '0.0.0.0'
---
---  local s1 = dgram.createSocket('udp4')
---  local s2 = dgram.createSocket('udp4')
---
---  s2:on('message', function(msg, rinfo)
---    assert(#msg == 5)
---    assert(msg == 'HELLO')
---    s2:close()
---    s1:close()
---  end)
---
---  p('PORT',PORT)
---  s2:bind(PORT+1,HOST)
---  s1:bind(PORT,HOST)
---
---  assert(s2:addMembership('239.255.0.1'))
---
---  s1:send('HELLO', PORT+1, '127.0.0.1')
---end
---```
local dgram = {}

---`Socket` extends `Emitter` and inherits all the events thereof. The 
---`dgram.Socket` class encapsulates the datagram functionality. It should be 
---created via `dgram.createSocket(...)`
---@class luvit.dgram.Socket : luvit.Emitter
local Socket = {}
dgram.Socket = Socket

---@generic obj
---@param self obj
---@param type any
---@param callback? fun(data?: string, addr?: luvit.dgram.Address, flags: luvit.dgram.RecvFlags)
---@return obj
function Socket:new(type, callback) end

---@class luvit.dgram.Address
---@field ip string
---@field port integer
---@field family string

---@class luvit.dgram.RecvFlags
---@field partial? boolean
---@field mmsg_chunk? boolean

---@param type any
---@param callback? fun(data?: string, addr?: luvit.dgram.Address, flags: luvit.dgram.RecvFlags)
function Socket:initialize(type, callback) end

---Start receiving on socket
function Socket:recvStart() end

---Stop listening on socket
---@return integer code
function Socket:recvStop() end

---Sets a socket timeout  
---@param msecs number
---@param callback? fun()
function Socket:setTimeout(msecs, callback) end

---Sends data down the udp socket
---@param data string|string[]
---@param port integer
---@param host string
---@param callback? fun(err?: string)
function Socket:send(data, port, host, callback) end

---@class luvit.dgram.BindOptions
---@field ipv6only boolean
---@field reuseaddr boolean

---Starts listening on the specified port and host.
---@param port integer
---@param host string
---@param options? luvit.dgram.BindOptions
function Socket:bind(port, host, options) end

---Closes a socket instance and fires the callback after cleanup
---@param callback? fun()
function Socket:close(callback) end

---Returns an object containing the address information for a socket. For UDP 
---sockets, this object will contain `address`, `family` and `port`.
---@return luvit.dgram.Address
function Socket:address() end

---@param status boolean -- Sets or clears the `SO_BROADCAST` socket option. When this option is set, UDP packets may be sent to a local interface's broadcast address.
function Socket:setBroadcast(status) end

---Sets membership status for a multicast group. Argument `op` can be 'join' or 'leave'.
---@param multicastAddress string
---@param interfaceAddress? string
---@param op "join" | "leave"
---@return integer code
function Socket:setMembership(multicastAddress, interfaceAddress, op) end

---Tells the kernel to join a multicast group with `IP_ADD_MEMBERSHIP` socket option.
---
---Equivalent to `Socket:setMembership(multicastAddress, interfaceAddress, "join")`
---@param multicastAddress string
---@param interfaceAddress? string
---@return integer code
function Socket:addMembership(multicastAddress, interfaceAddress) end

---Opposite of `Socket:addMembership` - tells the kernel to leave a multicast 
---group with `IP_DROP_MEMBERSHIP` socket option. This is automatically called 
---by the kernel when the socket is closed or process terminates, so most apps 
---will never need to call this.
---
---If `multicastInterface` is not specified, the OS will try to drop membership
---to all valid interfaces.
---
---Equivalent to `Socket:setMembership(multicastAddress, interfaceAddress, "leave")`
---@param multicastAddress string
---@param interfaceAddress string
function Socket:dropMembership(multicastAddress, interfaceAddress) end

---Sets the `IP_TTL` socket option. TTL stands for "Time to Live," but in this 
---context it specifies the number of IP hops that a packet is allowed to go 
---through. Each router or gateway that forwards a packet decrements the TTL. 
---If the TTL is decremented to 0 by a router, it will not be forwarded. 
---Changing TTL values is typically done for network probes or when 
---multicasting.
---@param ttl integer -- a number of hops between 1 and 255. The default on most systems is 64.
function Socket:setTTL(ttl) end

---Creates a new datagram socket.`callback` is triggered every time the 
---`'message'` event gets emitted.
---@param type "udp4" | "udp6" | string
---@param callback? fun(data?: string, addr?: luvit.dgram.Address, flags: luvit.dgram.RecvFlags)
function dgram.createSocket(type, callback) end

return dgram
---@meta
---A simple pair of functions for converting between hex and raw strings.
local httpCodec = {}

---@class luvit.http-codec.Item
---@field version? number|string
---@field method string
---@field path string
---@field code string
---@field reason? string
---@field [integer] { [1]: string, [2]: string }

---Returns a function. See the source at `http.lua:ServerResponse` for an 
---example.
---@return fun(item: luvit.http-codec.Item): string
function httpCodec.encoder() end

---Returns a function which takes one argument. See the source at `http.lua` 
---for an example.
---@return fun(chunk: string): luvit.http-codec.Item
function httpCodec.decoder() end

return httpCodec
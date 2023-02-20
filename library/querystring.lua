---@meta

---This module provides utilities for dealing with query strings.
local querystring = {}

---Serialize an object to a query string. Optionally override the default 
---separator (`'&'`) and assignment (`'='`) characters.
---
---Example:
---
---```
---do
---  querystring.stringify({
---    foo = 'bar', 
---    baz = {'qux', 'quux'}, 
---    corge = '' 
---  }) --> 'foo=bar&baz=qux&baz=quux&corge='
---
---  querystring.stringify({ foo = 'bar', baz = 'qux' }, ';', ':') 
---  --> 'foo:bar;baz:qux'
---end
---```
---@nodiscard
---@param obj table
---@param sep? string -- Defaults to `'&'`
---@param eq? string -- Defaults to `'='`
---@return string
function querystring.stringify(obj, sep, eq) end

---Deserialize a query string to an object. Optionally override the default 
---separator (`'&'`) and assignment (`'='`) characters.
---
---Example:
---
---```lua
---do
---  querystring.parse('foo=bar&baz=qux&baz=quux&corge')
---  --> { foo = 'bar', baz = {'qux', 'quux'}, corge = '' }
---end
---```
---@nodiscard
---@param str string
---@param sep? string -- Defaults to `'&'`
---@param eq? string -- Defaults to `'='`
---@return { [string]: (string|string[]) }
function querystring.parse(str, sep, eq) end

---Escapes special characters in a url.
---
---```lua
---do
---  querystring.urlencode('https://github.com/luvit/luvit/blob/master/deps/querystring.lua')
---  --> 'https%3A%2F%2Fgithub%2Ecom%2Fluvit%2Fluvit%2Fblob%2Fmaster%2Fdeps%2Fquerystring%2Elua'
---end
---```
---@nodiscard
---@param str string
---@return string
function querystring.urlencode(str) end

---Un-escapes special characters in a url.
---
---```lua
---do
---  querystring.urldecode('https%3A%2F%2Fgithub%2Ecom%2Fluvit%2Fluvit%2Fblob%2Fmaster%2Fdeps%2Fquerystring%2Elua')
---  --> 'https://github.com/luvit/luvit/blob/master/deps/querystring.lua'
---end
---```
---@nodiscard
---@param str string
---@return string
function querystring.urldecode(str) end

return querystring
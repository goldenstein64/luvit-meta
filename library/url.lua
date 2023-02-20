---@meta

---Node-style url codec for luvit
local url = {}

---@class luvit.url.ParseResult
---@field protocol string?
---@field host string?
---@field hostname string?
---@field port string -- Defaults to `'/'`
---@field path string -- Defaults to `'/'`
---@field search string?
---@field query string?
---@field auth string?
---@field hash string?
---@field href string

---@class luvit.url.FormatOptions
---@field protocol string?
---@field host string?
---@field hostname string?
---@field port string
---@field path string
---@field search string?
---@field query string?
---@field auth string?
---@field hash string?

---Takes a url string, returns an object.
---@param url string
---@param parseQueryString? boolean -- Pass in `true` if you'd like to pass the query part of the url through the `querystring.parse()` function.
---@return luvit.url.ParseResult
function url.parse(url, parseQueryString) end

---@param parsed string | luvit.url.FormatOptions
---@return string href
function url.format(parsed) end

---@param source string | luvit.url.ParseResult
---@param relative string | luvit.url.ParseResult
---@return luvit.url.ParseResult
function url.resolveObject(source, relative) end

---@param source string | luvit.url.ParseResult
---@param relative string | luvit.url.ParseResult
---@return string href
function url.resolve(source, relative) end

return url
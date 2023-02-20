---@meta

local httpHeader = {}

---@class luvit.http-header.Header
---@field [string] string
---@field [integer] string

---Provides a nice case-insensitive interface to headers
---@type { __index: fun(list: table, name: any): (value: any), __newindex: fun(list: table, name: any, value: any) }
httpHeader.headerMeta = {}

---Creates a new headers table or sets the metatable of `tbl` to headerMeta
---@param tbl? table
---@return luvit.http-header.Header tbl
function httpHeader.newHeaders(tbl) end

---Adds all header information found in `tbl` into `headers`, which should be 
---a table with `httpHeader.headerMeta` as its metatable.
---The input `tbl` can have keys in any of the following formats:
---
---```lua
---{
---  ["name"] = value,
---  ["name"] = {multiple, values},
---  {"name", value},
---}
---```
---
---Note: String keys in `tbl` will overwrite the key's value(s) in `headers` 
---if it exists
---@param tbl? table
---@param headers table
---@return luvit.http-header.Header headers
function httpHeader.appendToHeaders(tbl, headers) end

---Converts a table of headers into a headers table.
---The input `tbl` can have keys in any of the following formats:
---
---```lua
---{
---  ["name"] = value,
---  ["name"] = {multiple, values},
---  {"name", value},
---}
---```
---@param tbl? table
---@return luvit.http-header.Header headers
function httpHeader.toHeaders(tbl) end

---Converts and combines any table(s) of headers to a single headers table.
---The input tables can have keys in any of the following formats:
---
---```lua
---{
---  ["name"] = value,
---  ["name"] = {multiple, values},
---  {"name", value},
---}
---```
---
---Note: Duplicate string keys will overwrite eachother, with the last duplicate 
---key of the last table taking precedence
---@param ... table
---@return luvit.http-header.Header headers
function httpHeader.combineHeaders(...) end

---Extracts headers from a table that has array-like keys of 
---`{headerName, value}` tables.
---Ignores any non-array-like keys of the table.
---@param tbl? {[1]: string, [2]: string }[]
---@return luvit.http-header.Header headers
function httpHeader.getHeaders(tbl) end

return httpHeader
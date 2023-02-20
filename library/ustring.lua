---@meta

---A light-weight UTF-8 module in pure lua(jit).
local ustring = {}

---@class luvit.UString : string
---@field [integer] string
---@operator concat(luvit.UString): luvit.UString
local UString = {}

---Get the length of a UTF-8 character. Invalid characters yield a length of 0.
---@nodiscard
---@param byte integer
---@return 0|1|2|3|4
function ustring.chlen(byte) end

---Get the length of a UTF-8 character. Invalid characters yield a length of 0.
---@param byte integer
---@return 0|1|2|3|4
function UString.chlen(byte) end

---Create a UTF-8 string object from an existing string representation.
---@nodiscard
---@param str? string | luvit.UString
---@param allowInvalid? boolean -- Defaults to `false`.
---@return luvit.UString obj
function ustring.new(str, allowInvalid) end

---Create a UTF-8 string object from an existing string representation.
---@nodiscard
---@param allowInvalid? boolean -- Defaults to `false`.
---@return luvit.UString obj
function UString:new(allowInvalid) end

---Create a copy of a UTF-8 string object.
---@nodiscard
---@param ustr luvit.UString
---@return luvit.UString copy
function ustring.copy(ustr) end


---Create a copy of this UTF-8 string object.
---@nodiscard
---@return luvit.UString copy
function UString:copy() end

---Convert a raw index into the index of a UTF-8.
---
---Returns `nil` if `uIndex` is invalid.
---
---The last 2 arguments are optional and used for better performance (only if 
---`rawIndex` isn't negative)
---@nodiscard
---@param ustr luvit.UString
---@param rawIndex integer
---@param initRawIndex? integer
---@param initIndex? integer
---@return integer? uIndex
function ustring.index2uindex(ustr, rawIndex, initRawIndex, initIndex) end

---Convert a raw index into the index of a UTF-8.
---
---Returns `nil` if `uIndex` is invalid.
---
---The last 2 arguments are optional and used for better performance (only if 
---`rawIndex` isn't negative)
---@nodiscard
---@param rawIndex integer
---@param initRawIndex? integer
---@param initIndex? integer
---@return integer? uIndex
function UString:index2uindex(rawIndex, initRawIndex, initIndex) end

---Convert the index of a UIF-8 char into a raw index.
---
---Returns `nil` if `rawIndex` is invalid.
---
---The last 2 arguments are optional and used for better performance (only if 
---`uIndex` isn't negative)
---@nodiscard
---@param ustr luvit.UString
---@param uIndex? integer
---@param initRawIndex? integer
---@param InitUIndex? integer
---@return integer? rawIndex
function ustring.uindex2index(ustr, uIndex, initRawIndex, InitUIndex) end

---Convert the index of a UIF-8 char into a raw index.
---
---Returns `nil` if `rawIndex` is invalid.
---
---The last 2 arguments are optional and used for better performance (only if 
---`uIndex` isn't negative)
---@nodiscard
---@param uIndex? integer
---@param initRawIndex? integer
---@param InitUIndex? integer
---@return integer? rawIndex
function UString:uindex2index(uIndex, initRawIndex, InitUIndex) end

---@nodiscard
---@param ustr string|luvit.UString
---@param pattern string|luvit.UString
---@param repl string|luvit.UString
---@param n? integer
---@return luvit.UString
function ustring.gsub(ustr, pattern, repl, n) end

---@nodiscard
---@param pattern string|luvit.UString
---@param repl string|luvit.UString
---@param n? integer
---@return luvit.UString
function UString:gsub(pattern, repl, n) end

---@nodiscard
---@param ustr luvit.UString
---@param i integer
---@param j? integer
---@return luvit.UString
function ustring.sub(ustr, i, j) end

---@nodiscard
---@param i integer
---@param j? integer
---@return luvit.UString
function UString:sub(i, j) end

---@nodiscard
---@param ustr luvit.UString
---@param pattern string|luvit.UString
---@param init? integer
---@param plain? boolean
---@return integer?, integer?
function ustring.find(ustr, pattern, init, plain) end

---@nodiscard
---@param pattern string|luvit.UString
---@param init? integer
---@param plain? boolean
---@return integer?, integer?
function UString:find(pattern, init, plain) end

---@nodiscard
---@param formatString string | luvit.UString
---@param ... any
---@return luvit.UString
function ustring.format(formatString, ...) end

---@nodiscard
---@param ... any
---@return luvit.UString
function UString:format(...) end

---@nodiscard
---@param ustr string | luvit.UString
---@param pattern string
---@return fun(): string, ...unknown
function ustring.gmatch(ustr, pattern) end

---@nodiscard
---@param pattern string
---@return fun(): string, ...unknown
function UString:gmatch(pattern) end

---@nodiscard
---@param ustr string | luvit.UString
---@param pattern string | luvit.UString
---@param init? integer
---@return any ...
function ustring.match(ustr, pattern, init) end

---@nodiscard
---@param pattern string | luvit.UString
---@param init? integer
---@return any ...
function UString:match(pattern, init) end

---@nodiscard
---@param ustr luvit.UString
---@return luvit.UString
function ustring.lower(ustr) end

---@nodiscard
---@return luvit.UString
function UString:lower() end

---@param ustr luvit.UString
---@return luvit.UString
function ustring.upper(ustr) end

---@return luvit.UString
function UString:upper() end

---@nodiscard
---@param ustr luvit.UString
---@param n integer
---@return luvit.UString
function ustring.rep(ustr, n) end

---@nodiscard
---@param n integer
---@return luvit.UString
function UString:rep(n) end

---@nodiscard
---@param ustr luvit.UString
---@return luvit.UString
function ustring.reverse(ustr) end

---@nodiscard
---@return luvit.UString
function UString:reverse() end

return ustring
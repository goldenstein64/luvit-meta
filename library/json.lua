---@meta

---David Kolf's JSON library repackaged for lit.
---@class luvit.json
local json = {}

json.original_version = "" ---@type string

json.null = {} ---@type table

---@param value string
---@return string
function json.quotestring(value) end

---@param state table
function json.addnewline(state) end

---@param reason string
---@param value any
---@param state table
---@param defaultmessage string
---@return string
function json.encodeexception(reason, value, state, defaultmessage) end

---@param value table | string | boolean | number | nil
---@param state table?
function json.encode(value, state) end

---@param str string
---@param pos integer?
---@param nullval any?
---@param objectmeta table?
---@param arraymeta table?
function json.decode(str, pos, nullval, objectmeta, arraymeta) end

---@return luvit.json
function json.use_lpeg() end

json.parse = json.decode
json.stringify = json.encode

return json
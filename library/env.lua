---@meta

---Provides read/write access to local environment variables
local env = {}

---Get all environment variables.
---@return string[]
function env.keys() end

---Get an environment variable.
---@param name string
---@return string
function env.get(name) end

---Set an environment variable.
---@param name string
---@param value string
function env.set(name, value) end

---Delete an environment variable.
---@param name string
function env.unset(name) end

---@type string
env.os = nil

---@type string
env.arch = nil

return env
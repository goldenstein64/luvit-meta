---@meta
---Luvit's custom require system with relative requires and sane search paths.

---@class luvit.require.Module
---@field path string -- path to module
---@field dir string -- path to directory containing module
---@field exports table
local Module = {}

---@param path string
---@return string? data, string? err
function Module:load(path) end

---@param path string
---@return fun(): { name: string, type: string }
function Module:scan(path) end

---@param path string
---@return uv.fs_stat.result? stat, string? err
function Module:stat(path) end

---@generic ret
---@param path string
---@param action fun(path: string): ret
---@return ret
function Module:action(path, action) end

---@param name string
---@return boolean? success, string? bundlePath, string? path
function Module:resolve(name) end

---@param name string
---@return any
function Module:require(name) end

---@param modulePath string
---@return (fun(...: any): any) require, luvit.require.Module module
local function generator(modulePath) end

return generator
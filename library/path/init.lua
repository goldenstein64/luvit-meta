---@meta

---This module contains utilities for handling and transforming file paths. 
---Almost all these methods perform only string transformations. The file 
---system is not consulted to check whether paths are valid. Supports both 
---windows and posix.
local path = {}

---Gets the filesystem's root path.
---@param filepath string
---@return string
function path.getRoot(filepath) end

---Gets the filesystem's default path seperator.
function path.getSep() end

---Checks if path `a` is equal to `b`
---@param a string
---@param b string
---@return boolean
function path.pathEquals(a, b) end

---Normalize a string path, taking care of `'..'` and `'.'` parts.
---
---When multiple slashes are found, they're replaced by a single one; when the 
---path contains a trailing slash, it is preserved. On Windows backslashes are 
---used.
---@param filepath string
---@return string
function path.normalize(filepath) end

---Joins a splat of different strings together with the default seperator to 
---form a valid path.
---@param ... string
---@return string
function path.join(...) end

---Works backwards, joining the arguments until it resolves to an absolute 
---path. If an absolute path is not resolved, then the current working 
---directory is prepended.
---
---E.g.
---
---```lua
---path.resolve('/foo/bar', '/tmp/file/') --> '/tmp/file/'
---```
function path.resolve(...) end

---Returns the relative path from `from` to `to` If no relative path can be 
---solved, then `to` is returned.
function path.relative(from, to) end

---Return the directory name of a path. Similar to the Unix `dirname` command.
---@param filepath string
---@return string
function path.dirname(filepath) end

---Return the last portion of a path. Similar to the Unix `basename` command.
---@param filepath string
---@param expected_ext? string
---@return string
function path.basename(filepath, expected_ext) end

---Return the extension of the path, from the last `'.'` to end of string in 
---the last portion of the path. If there is no `'.'` in the last portion of 
---the path or the first character of it is `'.'`, then it returns an empty 
---string.
---@param filepath string
---@return string
function path.extname(filepath) end

---Checks if filepath is absolute.
---@param filepath string
---@return boolean
function path.isAbsolute(filepath) end

---Checks if the path follows Microsoft's universal naming convention
---@param filepath string
---@return boolean
function path.isUNC(filepath) end

---Drive-relative paths are unique to Windows and use the format 
---`<letter>:filepath`
---@param filepath string
---@return boolean
function path.isDriveRelative(filepath) end

---Returns file path with platform-specific seperators
---@param filepath string
---@return string
function path.normalizeSeparators(filepath) end

return path
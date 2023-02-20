---@meta

---This module contains utilities for handling and transforming file paths. 
---Almost all these methods perform only string transformations. The file 
---system is not consulted to check whether paths are valid. Supports both 
---windows and posix.
local path_base = {}

---@class luvit.path.Path : luvit.Object
---@field root string
---@field sep string
local Path = {}

---@param root string
---@param sep string
function Path:initialize(root, sep) end

---@generic obj
---@param self obj
---@param root string
---@param sep string
---@return obj
function Path:new(root, sep) end

---@protected
---@param key any
function Path:_get(key) end

---Gets the filesystem's root path.
---@return string root
function Path:getRoot() end

---Gets the filesystem's default path seperator.
---@return string sep
function Path:getSep() end

---Checks if path `a` is equal to `b`
---@param a string
---@param b string
---@return boolean
function Path:pathsEqual(a, b) end

---@protected
---Split a filename into [root, dir, basename]
---@param filename string
---@return string root, string dir, string basename
function Path:_splitPath(filename) end

---@protected
---Modifies an array of path parts in place by interpreting "." and ".." segments
---@param parts string[]
---@param isrelative? boolean
function Path:_normalizeArray(parts, isrelative) end

---@protected
---@param filepath string
---@return string[]
function Path:_splitBySeparators(filepath) end

---@param filepath string
---@return string
function Path:normalize(filepath) end

---@protected
---@param parts string[]
---@return string[]
function Path:_filterparts(parts) end

---@protected
---@param parts string[]
---@return string
function Path:_rawjoin(parts) end

---@protected
---@param ... string
---@return string, string[]
function Path:_filteredjoin(...) end

---@param ... string
---@return string
function Path:join(...) end

---Works backwards, joining the arguments until it resolves to an absolute 
---path. If an absolute path is not resolved, then the current working 
---directory is prepended.
---
---E.g.
---
---```lua
---path.resolve('/foo/bar', '/tmp/file/') --> '/tmp/file/'
---```
---@param ... string
---@return string
function Path:resolve(...) end

---@protected
---Returns the common parts of the given paths or `{}` if no common parts were 
---found.
---@param ... string
---@return string[]
function Path:_commonParts(...) end

---Returns the relative path from `from` to `to`. If no relative path can be 
---solved, then `to` is returned.
function Path:relative(from, to) end

---@param filepath string
---@return string
function Path:dirname(filepath) end

---@param filepath string
---@param expected_ext? string
---@return string
function Path:basename(filepath, expected_ext) end

---@param filepath string
---@return string
function Path:extname(filepath) end

---@class luvit.path.PosixPath : luvit.path.Path
local PosixPath = {}
path_base.posix = PosixPath

function PosixPath:initialize() end

---@generic obj
---@param self obj
---@return obj
function PosixPath:new() end

---@param filepath string
---@return boolean
function PosixPath:isAbsolute(filepath) end

---@param filepath string
---@return boolean
function PosixPath:isUNC(filepath) end

---@param filepath string
---@return boolean
function PosixPath:isDriveRelative(filepath) end

---@param filepath string
---@return string
function PosixPath:normalizeSeparators(filepath) end

---@protected
---@param filepath string
---@return string
function PosixPath:_makeLong(filepath) end

---@class luvit.path.WindowsPath : luvit.path.Path
local WindowsPath = {}
path_base.nt = WindowsPath

function WindowsPath:initialize() end

---@generic obj
---@param self obj
---@return obj
function WindowsPath:new() end

---Windows paths are case-insensitive
---@param a string
---@param b string
---@return boolean
function WindowsPath:pathsEqual(a, b) end

---@param filepath string
---@return boolean
function WindowsPath:isAbsolute(filepath) end

---@param filepath string
---@return boolean
function WindowsPath:isUNC(filepath) end

---@param filepath string
---@return boolean
function WindowsPath:isDriveRelative(filepath) end

---@param filepath? string
---@return string
function WindowsPath:getRoot(filepath) end

---@param ... string
---@return string
function WindowsPath:join(...) end

---@param filepath string
---@return string
function WindowsPath:normalizeSeparators(filepath) end

---@protected
---@param filepath string
---@return string
function WindowsPath:_makeLong(filepath) end

return path_base
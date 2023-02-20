---@meta

---Node-style filesystem module for luvit
---
---Uses lib uv under the hood. A lot of these functions are very similiar to 
---linux system calls and can be understood by reading the man pages of linux 
---command line commnds with the same names.
---
---The asynchronous form always takes a completion callback as its last 
---argument. The arguments passed to the completion callback depend on the 
---method, but the first argument is always reserved for an exception. If the 
---operation was completed successfully, then the first argument will be null 
---or undefined.
---
---Sync versions of functions usually return true if they succeed or an error 
---if they don't and no data is expected. Otherwise they return the data on 
---success.
local fs = {}

---Close a file. No arguments other than a possible exception are given to the 
---completion callback.
---@param fileDescriptor integer
---@param callback fun(err?: string, success?: boolean)|thread	
function fs.close(fileDescriptor, callback) end

---Synchronous version of `fs.close()`.
---@param fileDescriptor integer
---@return boolean success, string? err
function fs.closeSync(fileDescriptor) end

---Asynchronous file open. 
---@param path string
---@param flags? uv.fs_open.flags -- Default is `'r'`.
---@param mode? integer|string -- sets the file mode (permission and sticky bits), but only if the file was created. Defaults is octal `0666`, readable and writeable.
---@param callback fun(err?: string, fd?: integer)|thread
---@overload fun(path: string, callback: fun(err?: string, fileDescriptor?: integer)|thread)
---@overload fun(path: string, flags?: uv.fs_open.flags, callback: fun(err?: string, fileDescriptor?: integer)|thread)
---Flag `'rs'` is primarily useful for opening files on NFS mounts as it allows
---you to skip the potentially stale local cache. It has a very real impact on
---I/O performance so don't use this flag unless you need it.
---
---The exclusive flag 'x' (O_EXCL flag in open(2)) ensures that path is newly 
---created. On POSIX systems, path is considered to exist even if it is a 
---symlink to a non-existent file. The exclusive flag may or may not work with 
---network file systems.
---
---On Linux, positional writes don't work when the file is opened in append 
---mode. The kernel ignores the position argument and always appends the data 
---to the end of the file.
function fs.open(path, flags, mode, callback) end

---Synchronous version of `fs.open()`.
---@param path string
---@param flags? uv.fs_open.flags -- Default is `'r'`.
---@param mode? integer|string -- Default is octal `0666`.
---@return integer? fileDescriptor, string? err
---
---Flag `'rs'` is primarily useful for opening files on NFS mounts as it allows
---you to skip the potentially stale local cache. It has a very real impact on
---I/O performance so don't use this flag unless you need it.
---
---The exclusive flag `'x'` (O_EXCL flag in open(2)) ensures that path is newly 
---created. On POSIX systems, path is considered to exist even if it is a 
---symlink to a non-existent file. The exclusive flag may or may not work with 
---network file systems.
---
---On Linux, positional writes don't work when the file is opened in append 
---mode. The kernel ignores the position argument and always appends the data 
---to the end of the file.
function fs.openSync(path, flags, mode) end

---Read data from the file specified by `fileDescriptor`.
---@param fileDescriptor integer
---@param size integer -- the number of bytes to read. Defaults to 4096.
---@param offset integer -- the offset in the buffer to start reading at.
---@param callback fun(err?: string, bytesRead: integer, data: string)|thread
---@overload fun(fileDescriptor: integer, callback: fun(err?: string, bytesRead: integer, data: string)|thread)
---@overload fun(fileDescriptor: integer, size: integer, callback: fun(err?: string, bytesRead: integer, data: string)|thread)
function fs.read(fileDescriptor, size, offset, callback) end

---Synchronous version of `fs.read()`.
---@param fileDescriptor integer
---@param size? integer -- the number of bytes to read. Defaults to 4096.
---@param offset? integer -- the offset in the buffer to start reading at.
---@return string? data, string? err
function fs.readSync(fileDescriptor, size, offset) end

---Asynchronous delete file. No arguments other than a possible exception are 
---given to the completion callback.
---@param path string
---@param callback fun(err?: string, success?: boolean)|thread
function fs.unlink(path, callback) end

---Synchronous version of `fs.unlink()`.
---@return boolean? success, string? err
function fs.unlinkSync(path) end

---Writes a string `data` to a file `fileDescriptor` calling a function `callback` with 
---`err` or `nil` when done. `offset` is the offset in the buffer to start writing 
---at.
---@param fileDescriptor integer
---@param offset? integer
---@param data string|string[]
---@param callback fun(err?: string, bytesWritten?: integer)|thread
---@overload fun(fileDescriptor: integer, callback: fun(err?: string, bytesWritten?: integer)|thread, data: string)
function fs.write(fileDescriptor, offset, data, callback) end

---Synchronous version of `fs.write()`.
---@param fileDescriptor integer
---@param offset? integer
---@param data string|string[]
---@return integer? bytesWritten, string? err
function fs.writeSync(fileDescriptor, offset, data) end

---Creates a directory with name `path` and calls `callback` with `err` or 
---`nil`. `mode` is the permissions set on the directory, defaults to octal 0777
---@param path string
---@param mode? integer|string
---@param callback fun(err?: string, success?: true)|thread
---@overload fun(path: string, callback: fun(err?: string, success?: boolean)|thread)
function fs.mkdir(path, mode, callback) end

---Synchronous version of `fs.mkdir()`.
---@param path string
---@param mode? integer|string
---@return boolean? success, string? err
function fs.mkdirSync(path, mode) end

---Makes a directory from a template object
---@param template string
---@param callback fun(err?: string, path?: string)|thread
function fs.mkdtemp(template, callback) end

---Synchronous version of `fs.mkdtemp()`.
---@param template string
---@return string? path, string? err
function fs.mkdtempSync(template) end

---Removes a directory
---@param path string
---@param callback fun(err?: string, success?: boolean)|thread
function fs.rmdir(path, callback) end

---Synchronous version of `fs.rmdir()`.
---@param path string
---@return boolean? success, string? err
function fs.rmdirSync(path) end

---Reads a directory, returning files and folders in it in the callback. First 
---argument of `callback` is `nil` or `err`. This function is not recursive. 
---Use the `luvit-walk` package for a recursive variant
---@param path string
---@param callback fun(err?: luvit.Error, files?: string[])|thread
function fs.readdir(path, callback) end

---Synchronous version of `fs.readdir()`.
---@param path string
---@return string[] files
function fs.readdirSync(path) end

---Similiar to `fs.readdir()` but the callback here gets a function instead of 
---a table containing the list of files. Every time this function is invoked it 
---returns the name of the file/dir and the type of the file/dir (either file 
---or directory).
---@param path string
---@param callback fun(err?: string, iterator: fun(): (fileName: string, fileType: string))|thread
function fs.scandir(path, callback) end

---Simply returns the iterator function retrieved in the async `fs.scandir()` 
---callback.
---@param path string
---@return fun(): (fileName: string, fileType: string) iterator
function fs.scandirSync(path) end

---Checks if a file exists. `callback` is called with `true` or `false` and an 
---error or `nil` in the first and second args respectively.
---@param path string
---@param callback fun(err?: string, exists?: boolean)
function fs.exists(path, callback) end

---Synchronous version of `fs.exists()`. Returns the args the callback gets in 
---the async version
---@return boolean? exists, string? err
function fs.existsSync(path) end

---@alias luvit.fs.StatTime { nsec: integer, sec: integer }

---Returns an object containing the status of a file or directory.
---@param path string
---@param callback fun(err?: string, stat?: uv.fs_stat.result)|thread
---```lua
---> fs.stat('/', function(err, stat) print(err) statData = stat end)
---uv_fs_t: 0x00ada5c0
---> nil
---statData
---{ 
---  dev = 16777220, 
---  mode = 16877, 
---  nlink = 31, 
---  uid = 0,
---  gid = 0, 
---  rdev = 0,
---  ino = 2, 
---  size = 1122, 
---  blksize = 4096, 
---  blocks = 0 
---  flags = 0, 
---  gen = 0,
---  atime = { nsec = 0, sec = 1444233226 }, 
---  mtime = { nsec = 0, sec = 1440200375 },
---  ctime = { nsec = 0, sec = 1440200375 }, 
---  birthtime = { nsec = 0, sec = 1428616447 }, 
---  type = 'directory',
---}
---```
function fs.stat(path, callback) end

---Synchronous version of `fs.stat()`. Returns either an error or the stat object.
---@param path string
---@return uv.fs_stat.result? stat, string? err
function fs.statSync(path) end

---Similiar to `fs.stat()` but expects a file descriptor as retrieved from 
---`fs.open()` or `fs.read()` instead of a path.
---@param fileDescriptor integer
---@param callback fun(err?: string, stat?: uv.fs_stat.result)|thread
function fs.fstat(fileDescriptor, callback) end

---Synchronous version of `fs.fstat()`.
---@param fileDescriptor integer
---@return uv.fs_stat.result? stat, string? err
function fs.fstatSync(fileDescriptor) end

---`fs.lstat()` is identical to `fs.stat()`, except that if path is a symbolic 
---link, then the link itself is stat-ed, not the file that it refers to.
---@param path string
---@param callback fun(err?: string, stat?: uv.fs_stat.result)|thread
function fs.lstat(path, callback) end

---Synchronous version of `fs.lstat()`.
---@param path string
---@return uv.fs_stat.result? stat, string? err
function fs.lstatSync(path) end

---Renames a file or directory located at the given `path` to the `newPath`. 
---The `callback` is called with either the error or `true`
---@param path string
---@param newPath string
---@param callback fun(err?: string, success?: boolean)|thread
function fs.rename(path, newPath, callback) end

---Synchronous version of `fs.rename()`.
---@param path string
---@param newPath string
---@return boolean? success, string? err
function fs.renameSync(path, newPath) end

---Async fsync. No arguments other than a possible exception are given to the 
---completion callback.
---
---`fs.fsync()` transfers ("flushes") all modified in-core data of (i.e., 
---modified buffer cache pages for) the file referred to by the file descriptor 
---`fileDescriptor` to the disk device (or other permanent storage device) so 
---that all changed information can be retrieved even after the system crashed 
---or was rebooted. This includes writing through or flushing a disk cache if 
---present. The call blocks until the device reports that the transfer has 
---completed. It also flushes metadata information associated with the file 
---(see `stat(2)`).
---
---Calling `fs.fsync()` does not necessarily ensure that the entry in the 
---directory containing the file has also reached disk. For that an explicit 
---`fs.fsync()` on a file descriptor for the directory is also needed.
---@param fileDescriptor integer
---@param callback fun(err?: string, success?: boolean)|thread
function fs.fsync(fileDescriptor, callback) end

---Synchronous version of `fs.fsync()`.
---@param fileDescriptor integer
---@return boolean? success, string? err
function fs.fsyncSync(fileDescriptor) end

---`fs.fdatasync()` is similar to `fs.fsync()`, but does not flush modified 
---metadata unless that metadata is needed in order to allow a subsequent data 
---retrieval to be correctly handled. For example, changes to `st_atime` or 
---`st_mtime` (respectively, time of last access and time of last modification; 
---see `stat(2)`) do not require flushing because they are not necessary for a 
---subsequent data read to be handled correctly. On the other hand, a change 
---to the file size (`st_size`, as made by say `ftruncate(2)`), would require a 
---metadata flush.
---
---The aim of `fs.fdatasync()` is to reduce disk activity for applications that 
---do not require all metadata to be synchronized with the disk.
---@param fileDescriptor integer
---@param callback fun(err?: string, success?: boolean)|thread
function fs.fdatasync(fileDescriptor, callback) end

---Synchronous version of `fs.fdatasync()`.
---@param fileDescriptor integer
---@return boolean? success, string? err
function fs.fdatasyncSync(fileDescriptor) end

---Shrink or extend the size of each `FILE` to the specified size.
---
---A `FILE` argument that does not exist is created.
---
---If a `FILE` is larger than the specified size, the extra data is lost. If a 
---`FILE` is shorter, it is extended and the extended part (hole) reads as zero 
---bytes.
---@param fileDescriptor integer
---@param offset? integer
---@param callback fun(err?: string, success?: boolean)|thread
---@overload fun(fileDescriptor: integer, callback: fun(err?: string, success?: boolean)|thread)
function fs.ftruncate(fileDescriptor, offset, callback) end

---Synchronous version of `fs.ftruncate()`.
---@param fileDescriptor integer
---@param offset? integer
---@return boolean? success, string? err
function fs.ftruncateSync(fileDescriptor, offset) end

---`fs.sendfile()` copies data between one file descriptor and another. Because 
---this copying is done within the kernel, `fs.sendfile()` is more efficient 
---than the combination of `fs.read()` and `fs.write()`, which would require 
---transferring data to and from user space.
---@param outFd integer
---@param inFd integer
---@param offset integer
---@param length integer
---@param callback fun(err?: string, bytesWritten?: integer)|thread
function fs.sendfile(outFd, inFd, offset, length, callback) end

---Synchronous version of `fs.sendfile()`.
---@param outFd integer
---@param inFd integer
---@param offset integer
---@param length integer
---@return integer? bytesWritten, string? err
function fs.sendfileSync(outFd, inFd, offset, length) end

---@alias luvit.fs.AccessFlags
---|> "" # File is visible to the calling process. This is useful for determining if a file exists, but says nothing about `rwx` permissions. Default if no mode is specified.
---| "r" # File can be read by the calling process.
---| "w" # File can be written by the calling process.
---| "x" # File can be executed by the calling process. This has no effect on Windows (will behave like "").
---| "rw"
---| "rx"
---| "wx"
---| "rwx"

---Tests a user's permissions for the file specified by `path`. `flags` is an 
---optional integer that specifies the accessibility checks to be performed. 
---It is possible to create a mask consisting of the concatenation of two or 
---more values.
---
---The final argument, `callback`, is a callback function that is invoked with 
---a possible error argument. If any of the accessibility checks fail, the 
---error argument will be populated.
---@param path string
---@param flags? integer|string|luvit.fs.AccessFlags
---@param callback fun(err?: string, permission?: boolean)|thread
---@overload fun(path: string, callback: fun(err?: string, permission?: boolean)|thread)
function fs.access(path, flags, callback) end

---Synchronous version of `fs.access()`.
---@param path string
---@param flags? integer|string|luvit.fs.AccessFlags
function fs.accessSync(path, flags) end

---Asynchronous `chmod(2)`. Changes a file's mode bits using a bit mask. No 
---arguments other than a possible exception are given to the completion 
---callback.
---
---To change a file's mode bits from a file descriptor, see `fs.fchmod()`.
---
---* `0x1` : `S_IXOTH` - execute/search by others
---* `0x2` : `S_IWOTH` - write by others
---* `0x4` : `S_IROTH` - read by others
---* `0x8` : `S_IXGRP` - execute/search by group
---* `0x10` : `S_IWGRP` - write by group
---* `0x20` : `S_IRGRP` - read by group
---  directories, and means that entries within the directory can be accessed)
---* `0x40` : `S_IXUSR` - execute/search by owner ("search" applies for 
---* `0x80` : `S_IWUSR` - write by owner
---* `0x100` : `S_IRUSR` - read by owner
---* `0x200` : `S_ISVTX` - sticky bit (restricted deletion flag, as described 
---  in `unlink(2)`)
---* `0x400` : `S_ISGID` - set-group-ID (set process effective group ID on 
---  `execve(2)`; mandatory locking, as described in `fcntl(2)`; take a new 
---  file's group from parent directory, as described in `chown(2)` and 
---  `mkdir(2)`)
---* `0x800` : `S_ISUID` - set-user-ID (set process effective user ID on 
---  `execve(2)`)
---
---@param path string
---@param mode integer
---@param callback fun(err?: string, success?: boolean)|thread
function fs.chmod(path, mode, callback) end

---Synchronous version of `fs.chmod()`.
---
---* `0x1` : `S_IXOTH` - execute/search by others
---* `0x2` : `S_IWOTH` - write by others
---* `0x4` : `S_IROTH` - read by others
---* `0x8` : `S_IXGRP` - execute/search by group
---* `0x10` : `S_IWGRP` - write by group
---* `0x20` : `S_IRGRP` - read by group
---  directories, and means that entries within the directory can be accessed)
---* `0x40` : `S_IXUSR` - execute/search by owner ("search" applies for 
---* `0x80` : `S_IWUSR` - write by owner
---* `0x100` : `S_IRUSR` - read by owner
---* `0x200` : `S_ISVTX` - sticky bit (restricted deletion flag, as described 
---  in `unlink(2)`)
---* `0x400` : `S_ISGID` - set-group-ID (set process effective group ID on 
---  `execve(2)`; mandatory locking, as described in `fcntl(2)`; take a new 
---  file's group from parent directory, as described in `chown(2)` and 
---  `mkdir(2)`)
---* `0x800` : `S_ISUID` - set-user-ID (set process effective user ID on 
---  `execve(2)`)
---
---@param path string
---@param mode integer
---@return boolean? success, string? err
function fs.chmodSync(path, mode) end

---Asynchronous `fchmod(2)`. No arguments other than a possible exception are 
---given to the completion callback.
---
---To change a file's mode bits from a file path, see `fs.chmod()`.
---
---* `0x1` : `S_IXOTH` - execute/search by others
---* `0x2` : `S_IWOTH` - write by others
---* `0x4` : `S_IROTH` - read by others
---* `0x8` : `S_IXGRP` - execute/search by group
---* `0x10` : `S_IWGRP` - write by group
---* `0x20` : `S_IRGRP` - read by group
---  directories, and means that entries within the directory can be accessed)
---* `0x40` : `S_IXUSR` - execute/search by owner ("search" applies for 
---* `0x80` : `S_IWUSR` - write by owner
---* `0x100` : `S_IRUSR` - read by owner
---* `0x200` : `S_ISVTX` - sticky bit (restricted deletion flag, as described 
---  in `unlink(2)`)
---* `0x400` : `S_ISGID` - set-group-ID (set process effective group ID on 
---  `execve(2)`; mandatory locking, as described in `fcntl(2)`; take a new 
---  file's group from parent directory, as described in `chown(2)` and 
---  `mkdir(2)`)
---* `0x800` : `S_ISUID` - set-user-ID (set process effective user ID on 
---  `execve(2)`)
---
---@param fileDescriptor integer
---@param mode integer
---@param callback fun(err?: string, success?: boolean)|thread
function fs.fchmod(fileDescriptor, mode, callback) end

---Synchronous version of `fs.fchmod()`.
---
---* `0x1` : `S_IXOTH` - execute/search by others
---* `0x2` : `S_IWOTH` - write by others
---* `0x4` : `S_IROTH` - read by others
---* `0x8` : `S_IXGRP` - execute/search by group
---* `0x10` : `S_IWGRP` - write by group
---* `0x20` : `S_IRGRP` - read by group
---  directories, and means that entries within the directory can be accessed)
---* `0x40` : `S_IXUSR` - execute/search by owner ("search" applies for 
---* `0x80` : `S_IWUSR` - write by owner
---* `0x100` : `S_IRUSR` - read by owner
---* `0x200` : `S_ISVTX` - sticky bit (restricted deletion flag, as described 
---  in `unlink(2)`)
---* `0x400` : `S_ISGID` - set-group-ID (set process effective group ID on 
---  `execve(2)`; mandatory locking, as described in `fcntl(2)`; take a new 
---  file's group from parent directory, as described in `chown(2)` and 
---  `mkdir(2)`)
---* `0x800` : `S_ISUID` - set-user-ID (set process effective user ID on 
---  `execve(2)`)
---
---@param fileDescriptor integer
---@param mode integer
---@return boolean? success, string? err
function fs.fchmodSync(fileDescriptor, mode) end

---Async `utime(2)`. Changes file last access and modification times from a
---file path.
---@param path string
---@param atime number
---@param mtime number
---@param callback fun(err?: string, success?: boolean)|thread
function fs.utime(path, atime, mtime, callback) end

---Synchronous version of `fs.utime()`.
---@param path string
---@param atime number
---@param mtime number
---@return boolean? success, string? err
function fs.utimeSync(path, atime, mtime) end

---Async `futime(2)`. Chages file last access and modification times from a
---file descriptor.
---@param fileDescriptor integer
---@param atime number
---@param mtime number
---@param callback fun(err?: string, success?: boolean)|thread
function fs.futime(fileDescriptor, atime, mtime, callback) end

---Synchronous version of `fs.futime()`.
---@param fileDescriptor integer
---@param atime number
---@param mtime number
---@return boolean? success, string? err
function fs.futimeSync(fileDescriptor, atime, mtime) end

---`fs.link()` creates a new link (also known as a hard link) to an existing 
---file. If `newPath` exists, it will not be overwritten.
---
---This new name may be used exactly as the old one for any operation; both 
---names refer to the same file (and so have the same permissions and 
---ownership) and it is impossible to tell which name was the "original".
---@param path string
---@param newPath string
---@param callback fun(err?: string, success?: boolean)|thread
function fs.link(path, newPath, callback) end

---Synchronous version of `fs.link()`.
---@param path string
---@param newPath string
---@return boolean? success, string? err
function fs.linkSync(path, newPath) end

---Creates a soft link instead of a hard link as in `fs.link()`.
---@param path string
---@param newPath string
---@param options? integer|{ dir: boolean?, junction: boolean? }
---@param callback fun(err?: string, success?: boolean)|thread
---@overload fun(path: string, newPath: string, callback: fun(err?: string, success?: boolean)|thread)
function fs.symlink(path, newPath, options, callback) end

---Synchronous version of `fs.symlink()`.
---@param path string
---@param newPath string
---@param options? integer|{ dir: boolean?, junction: boolean? }
---@return boolean? success, string? err
function fs.symlinkSync(path, newPath, options) end

---Asynchronous `readlink(2)`. The callback gets two arguments 
---`(err, linkString)`. Prints value of a symbolic link or canonical file name.
---@param path string
---@param callback fun(err?: string, linkString?: string)|thread
function fs.readlink(path, callback) end

---Synchronous version of `fs.readlink()`.
---@param path string
---@return string? linkString, string? err
function fs.readlinkSync(path) end

---Async `chown(2)`. Changes ownership of a file.
---@param path string
---@param uid integer
---@param gid integer
---@param callback fun(err?: string, success?: boolean)|thread
function fs.chown(path, uid, gid, callback) end

---Synchronous version of `fs.chown()`
---@param path string
---@param uid integer
---@param gid integer
---@return boolean? success, string? err
function fs.chownSync(path, uid, gid) end

---Like `fs.chown()` but works with file descriptors.
---@param fileDescriptor integer
---@param uid integer
---@param gid integer
---@param callback fun(err?: string, success?: boolean)|thread
function fs.fchown(fileDescriptor, uid, gid, callback) end

---Synchronous version of `fs.fchown()`.
---@param fileDescriptor integer
---@param uid integer
---@param gid integer
function fs.fchownSync(fileDescriptor, uid, gid) end

---Reads a file to a string buffer which is returned as the second argument in 
---the callback. Works with virtual filesystems as well.
---@param path string
---@param callback fun(err?: string, data?: string)|thread
function fs.readFile(path, callback) end

---Synchronous version of `fs.readFile()`.
---@param path string
---@return string? data, string? err
function fs.readFileSync(path) end

---Writes a file.
---@param path string
---@param data string
---@param callback fun(err?: string)|thread
function fs.writeFile(path, data, callback) end

---Synchronous version of `fs.writeFile()`.
---@param path string
---@param data string
---@return boolean? success, string? err
function fs.writeFileSync(path, data) end

---Appends data to a file
---@param path string
---@param data string
---@param callback? fun(err?: string)
function fs.appendFile(path, data, callback) end

---Synchronous version of `fs.appendFileSync()`.
---@param path string
---@param data string
---@return string? err
function fs.appendFileSync(path, data) end

---Creates a writeable stream.
---
---```lua
---local path, cb, chunk = 'valid/path', validFunc, 'validString'
---local WritableChild = fs.WriteStream:extend()
---function WritableChild:_write(data, callback)
---  print('Wrote: '..data)
---  callback()
---end
---local writable = WritableChild:new(path, cb)
---writable:on('open', function() print('file opened')
---writable:write(chunk) -- optional callback
---writable:close()
---```
---@class luvit.fs.WriteStream : luvit.stream.Writable
local WriteStream = {}
fs.WriteStream = WriteStream

---@class luvit.fs.WriteStreamOptions
---@field fd integer -- file descriptor
---@field flags string -- `'w'` for write. See `fs.open()` for other possible flags
---@field mode integer -- file mode to write to. Defaults to `438` which is equivalent to octal `0666`
---@field start integer -- start position

---You can set the path to the file and options here. `options` is a table with 
---the following key-value pairs
---
---* `fd` - file descriptor
---* `flags` - `'w'` for write. See `fs.open()` for other possible flags
---* `mode` - to write to. Defaults to `438` which is equivalent to octal `0666`
---* `start` - start position
---@param path string
---@param options luvit.fs.WriteStreamOptions
function WriteStream:initialize(path, options) end

---You can set the path to the file and options here. `options` is a table with 
---the following key-value pairs
---
---* `fd` - file descriptor
---* `flags` - `'w'` for write. See `fs.open()` for other possible flags
---* `mode` - to write to. Defaults to `438` which is equivalent to octal `0666`
---* `start` - start position
---@generic obj
---@param self obj
---@param path string
---@param options luvit.fs.WriteStreamOptions
---@return obj
function WriteStream:new(path, options) end

---Callback to fire when the write stream is opened. This callback gets no 
---arguments. An `'open'` event is also emitted with the file descriptor when 
---the file is opened.
---@param callback fun(err?: string)?
function WriteStream:open(callback) end

---Internal write utility. Bind the declared `_write` in your inherited class to 
---be called when the file is opened
---@param data string
---@param callback fun(err?: string)
function WriteStream:_write(data, callback) end

---Closes or destroys the write stream. Calls `WriteStream:destroy()`
function WriteStream:close() end

---Closes the write stream
function WriteStream:destroy() end

---Creates and returns a new write stream that is an instance of
---the `WriteStream` class with the given `path` and `options`
---@param path string
---@param options luvit.fs.WriteStreamOptions
---@return luvit.fs.WriteStream
function fs.createWriteStream(path, options) end

---A synchronous version of the WriteStream class. Extends WriteStream
---@class luvit.fs.WriteStreamSync : luvit.fs.WriteStream
local WriteStreamSync = {}
fs.WriteStreamSync = WriteStreamSync

---A parent class for creating readable streams from files.
---@class luvit.fs.ReadStream : luvit.stream.Readable
local ReadStream = {}
fs.ReadStream = ReadStream

---@class luvit.fs.ReadStreamOptions
---@field fd integer? -- file descriptor
---@field mode integer?
---@field offset integer?
---@field chunkSize integer?
---@field length integer? - nil means read to EOF

---Initializer for the ReadStream class. Options table key values: 
---
---* `fd` - file descriptor 
---* `mode`
---* `offset` 
---* `chunkSize` 
---* `length` - nil means read to EOF
---@param path string
---@param options luvit.fs.ReadStreamOptions
function ReadStream:initialize(path, options) end

---Options table key values: 
---
---* `fd` - file descriptor 
---* `mode`
---* `offset` 
---* `chunkSize` 
---* `length` - nil means read to EOF
---@generic obj
---@param self obj
---@param path string
---@param options luvit.fs.ReadStreamOptions
---@return obj
function ReadStream:new(path, options) end

---Callback to fire when the read stream is opened. This callback gets no 
---arguments. An `'open'` event is also emitted with the file descriptor when the 
---file is opened
---@param callback fun(err?: string)
function ReadStream:open(callback) end

---Reads a file, `n` chunk bytes at a time. You can set the `n` in the init/new options
---@param n integer
function ReadStream:_read(n) end

---Closes the `ReadStream`.
function ReadStream:close() end

---Destroys the `ReadStream`. Gets called by `ReadStream:close()`. Emits 
---`'error'` with `err` if there's an error.
function ReadStream:destroy(err) end

---Function which creates and returns a new `ReadStream` instance with the set `path` and `options`
---@param path string
---@param options luvit.fs.ReadStreamOptions
---@return luvit.fs.ReadStream
function fs.createReadStream(path, options) end

return fs
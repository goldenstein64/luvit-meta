---@meta

---A port of node.js's stream module for luvit.
return {
  Stream = require('stream.stream_core').Stream,
  Writable = require('stream.stream_writable').Writable,
  Transform = require('stream.stream_transform').Transform,
  Readable = require('stream.stream_readable').Readable,
  PassThrough = require('stream.stream_passthrough').PassThrough,
  Observable = require('stream.stream_observable').Observable,
  Duplex = require('stream.stream_duplex').Duplex,
}
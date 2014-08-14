require 'ffi'
require 'ffi-compiler/loader'

module SecureCompare
  extend FFI::Library
  ffi_lib FFI::Compiler::Loader.find('secure_compare')
  
  attach_function :secure_compare_bytes, [:pointer, :uint, :pointer, :uint], :int

  def self.compare(secret, input)
    sBuf = FFI::MemoryPointer.new(:char, secret.size)
    sBuf.put_bytes(0, secret)
    iBuf = FFI::MemoryPointer.new(:char, input.size)
    iBuf.put_bytes(0, input)
    secure_compare_bytes(secret, secret.size, input, input.size) == 0
  end
end

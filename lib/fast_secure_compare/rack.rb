require 'fast_secure_compare'

# Monkeypatch Rack
module Rack
  module Utils
    class<< self
      def secure_compare(a, b)
        FastSecureCompare.compare(a, b)
      end
    end
  end
end

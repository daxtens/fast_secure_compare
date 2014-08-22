require 'fast_secure_compare'

# Monkeypatch Rails
module ActiveSupport
  class MessageVerifier
    private
    def secure_compare(a, b)
      FastSecureCompare.compare(a, b)
    end
  end
end

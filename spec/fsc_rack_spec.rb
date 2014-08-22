require 'fast_secure_compare/rack'

describe Rack::Utils, "#secure_compare" do
    it "returns true on equal strings" do
      expect(Rack::Utils.secure_compare("aaa","aaa")).to eq(true)
     end
    it "returns false on an empty string" do
      expect(Rack::Utils.secure_compare("aaa","")).to eq(false)
    end
    it "returns false on different strings of different length" do
      expect(Rack::Utils.secure_compare("aaa","a")).to eq(false)
      expect(Rack::Utils.secure_compare("aaa","aaaaaa")).to eq(false)
    end
    it "returns false on different strings of equal length" do
      expect(Rack::Utils.secure_compare("aaa","bbb")).to eq(false)
    end
    it "returns true on two empty strings." do
      expect(Rack::Utils.secure_compare("","")).to eq(true)
    end
    it "returns false on one empty string, one non-empty string." do
      expect(Rack::Utils.secure_compare("a","")).to eq(false)
      expect(Rack::Utils.secure_compare("","a")).to eq(false)
    end
end

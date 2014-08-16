require 'fast_secure_compare'

describe FastSecureCompare, "#compare" do
    it "returns true on equal strings" do
      expect(FastSecureCompare.compare("aaa","aaa")).to eq(true)
     end
    it "returns false on an empty string" do
      expect(FastSecureCompare.compare("aaa","")).to eq(false)
    end
    it "returns false on different strings of different length" do
      expect(FastSecureCompare.compare("aaa","a")).to eq(false)
      expect(FastSecureCompare.compare("aaa","aaaaaa")).to eq(false)
    end
    it "returns false on different strings of equal length" do
      expect(FastSecureCompare.compare("aaa","bbb")).to eq(false)
    end
    it "returns true on two empty strings." do
      expect(FastSecureCompare.compare("","")).to eq(true)
    end
    it "returns false on one empty string, one non-empty string." do
      expect(FastSecureCompare.compare("a","")).to eq(false)
      expect(FastSecureCompare.compare("","a")).to eq(false)
    end
end

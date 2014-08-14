require 'secure_compare'

describe SecureCompare, "#compare" do
    it "returns true on equal strings" do
      expect(SecureCompare.compare("aaa","aaa")).to eq(true)
     end
    it "returns false on an empty string" do
      expect(SecureCompare.compare("aaa","")).to eq(false)
    end
    it "returns false on different strings of different length" do
      expect(SecureCompare.compare("aaa","a")).to eq(false)
      expect(SecureCompare.compare("aaa","aaaaaa")).to eq(false)
    end
    it "returns false on different strings of equal length" do
      expect(SecureCompare.compare("aaa","bbb")).to eq(false)
    end
end

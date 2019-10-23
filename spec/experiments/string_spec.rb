require "spec_helper"

describe String do
  describe "#<<" do
    example "文字の追加" do
      s = "ABC"
      s << "D"
      expect(s.size).to eq(4)
    end
  end
end

require "rails_helper"

describe Admin::Authenticator do
  describe "#authenticate" do
    example "正しいパスワードならtrueを返す" do
      a = build(:administrator)
      expect(Admin::Authenticator.new(a).authenticate("pw")).to be_truthy
    end

    example "誤ったパスワードならfalseを返す" do
      a = build(:administrator)
      expect(Admin::Authenticator.new(a).authenticate("xy")).to be_falsey
    end

    example "パスワード未設定ならfalseを返す" do
      a = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(a).authenticate(nil)).to be_falsey
    end

    example "停止フラグが立っていてもtrueを返す" do
      a = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(a).authenticate("pw")).to be_truthy
    end
  end
end

require "rails_helper"

describe Admin::StaffMembersController, "ログイン前" do
  include_examples "a protected admin controller", "admin/staff_members"
end

describe Admin::StaffMembersController, type: :request do
  let(:params_hash) { attributes_for(:staff_member) }
  let(:administrator) { create(:administrator) }

  before do
    login_as(administrator)
  end

  describe "#create" do
    example "職員一覧ページにリダイレクト" do
      post admin_staff_members_url, params: { staff_member: params_hash }
      expect(response).to redirect_to(admin_staff_members_url)
    end

    example "例外ActionController::ParameterMissingが発生" do
      expect { post admin_staff_members_url }.
        to raise_error(ActionController::ParameterMissing)
    end
  end

  describe "#update" do
    let(:staff_member) { create(:staff_member) }

    example "suspendedフラグをセットする" do
      params_hash.merge!(suspended: true)
      patch admin_staff_member_url(staff_member),
        params: { staff_member: params_hash }
      staff_member.reload
      expect(staff_member).to be_suspended
    end

    example "hashed_passwordの値は書き換え不可" do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: "x")
      expect {
        patch admin_staff_member_url(staff_member),
          params: { staff_member: params_hash }
      }.not_to change { staff_member.hashed_password.to_s }
    end
  end
end

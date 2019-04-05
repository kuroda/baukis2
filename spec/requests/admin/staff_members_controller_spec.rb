require "rails_helper"

describe Admin::StaffMembersController, "ログイン前" do
  include_examples "a protected admin controller", "admin/staff_members"
end

describe Admin::StaffMembersController do
  let(:params_hash) { attributes_for(:staff_member) }
  let(:administrator) { create(:administrator) }

  describe "#index" do
    let(:staff_member) { create(:staff_member) }

    example "ログイン後ならページを表示" do
      login_as(administrator)
      get admin_staff_members_url
      expect(response).to be_ok
    end

    example "ログイン前なら「ログイン」フォームへ遷移させる" do
      get admin_staff_members_url

      expect(response).to redirect_to(admin_login_url)
    end

    example "停止フラグがセットされたら強制的にログアウト" do
      login_as(administrator)
      administrator.update_column(:suspended, true)
      get admin_staff_members_url
      expect(response).to redirect_to(admin_root_url)
    end

    example "セッションタイムアウト" do
      login_as(administrator)
      travel_to Admin::Base::TIMEOUT.from_now.advance(seconds: 1)
      get admin_staff_members_url
      expect(response).to redirect_to(admin_login_url)
    end
  end

  describe "#create" do
    before do
      login_as(administrator)
    end

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

    before do
      login_as(administrator)
    end

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

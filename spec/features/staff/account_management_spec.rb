require "rails_helper"

feature "職員によるアカウント管理" do
  include FeaturesSpecHelper
  let(:staff_member) { create(:staff_member) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
    click_link "アカウント"
    click_link "アカウント情報編集"
  end

  scenario "顧客がメールアドレス、氏名、フリガナを更新する" do
    fill_in "メールアドレス", with: "test@oiax.jp"
    fill_in "staff_member_family_name", with: "試験"
    fill_in "staff_member_given_name", with: "花子"
    fill_in "staff_member_family_name_kana", with: "テスト"
    fill_in "staff_member_given_name_kana", with: "テスト"
    click_button "確認画面へ進む"
    click_button "訂正"
    fill_in "staff_member_family_name_kana", with: "シケン"
    fill_in "staff_member_given_name_kana", with: "ハナコ"
    click_button "確認画面へ進む"
    click_button "更新"

    staff_member.reload
    expect(staff_member.email).to eq("test@oiax.jp")
    expect(staff_member.family_name).to eq("試験")
    expect(staff_member.given_name).to eq("花子")
    expect(staff_member.family_name_kana).to eq("シケン")
    expect(staff_member.given_name_kana).to eq("ハナコ")
  end

  scenario "職員がメールアドレスに無効な値を入力する" do
    fill_in "メールアドレス", with: "test@@oiax.jp"
    click_button "確認画面へ進む"

    expect(page).to have_css(
      "div.field_with_errors input#staff_member_email")
  end
end

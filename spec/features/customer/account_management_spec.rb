require "rails_helper"

feature "顧客によるアカウント管理" do
  include FeaturesSpecHelper
  let(:customer) { create(:customer) }

  before do
    switch_namespace(:customer)
    login_as_customer(customer)
    click_link "アカウント"
    click_link "編集"
  end

  scenario "顧客が基本情報、⾃宅住所、勤務先を更新する" do
    fill_in "生年月日", with: "1980-04-01"
    within("fieldset#home-address-fields") do
      fill_in "郵便番号", with: "9999999"
    end
    click_button "確認画面へ進む"
    click_button "訂正"
    within("fieldset#work-address-fields") do
      fill_in "会社名", with: "テスト"
    end
    click_button "確認画面へ進む"
    click_button "更新"
    
    customer.reload
    expect(customer.birthday).to eq(Date.new(1980, 4, 1))
    expect(customer.home_address.postal_code).to eq("9999999")
    expect(customer.work_address.company_name).to eq("テスト")
  end

  scenario "顧客が⽣年⽉⽇と⾃宅の郵便番号に無効な値を⼊⼒する" do
    fill_in "生年月日", with: "2100-01-01"
      within("fieldset#home-address-fields") do
    fill_in "郵便番号", with: "XYZ"
    end
    click_button "確認画面へ進む"
  
    expect(page).to have_css("header span.alert")
    expect(page).to have_css(
      "div.field_with_errors input#form_customer_birthday")
    expect(page).to have_css(
      "div.field_with_errors input#form_home_address_postal_code")
  end
end
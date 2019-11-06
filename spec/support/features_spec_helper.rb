module FeaturesSpecHelper
  def switch_namespace(namespace)
    config = Rails.application.config.baukis2
    Capybara.app_host = "http://" + config[namespace][:host]
  end

  def login_as_staff_member(staff_member, password = "pw")
    visit staff_login_path
    within("#login-form") do
      fill_in "メールアドレス", with: staff_member.email
      fill_in "パスワード", with: password
      click_button "ログイン"
    end
  end
end

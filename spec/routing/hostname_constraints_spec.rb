require "rails_helper"

describe "ルーティング" do
  let(:config) { Rails.application.config.baukis2 }

  example "職員トップページ" do
    expect(get: "http://#{config[:staff][:host]}").to route_to(
      host: config[:staff][:host],
      controller: "staff/top",
      action: "index"
    )
  end

  example "管理者ログインフォーム" do
    expect(get: "http://#{config[:admin][:host]}/admin/login").to route_to(
      host: config[:admin][:host],
      controller: "admin/sessions",
      action: "new"
    )
  end

  example "顧客トップページ" do
    expect(get: "http://#{config[:customer][:host]}/mypage").to route_to(
      host: config[:customer][:host],
      controller: "customer/top",
      action: "index"
    )
  end

  example "ホスト名が対象外ならroutableではない" do
    expect(get: "http://foo.example.jp").not_to be_routable
  end

  example "存在しないパスならroutableではない" do
    expect(get: "http://#{config[:staff][:host]}/xyz").not_to be_routable
  end
end

require "rails_helper"

describe "ルーティング" do
  example "職員トップページ" do
    expect(get: "http://baukis2.example.com").to route_to(
      host: "baukis2.example.com",
      controller: "staff/top",
      action: "index"
    )
  end

  example "管理者ログインフォーム" do
    expect(get: "http://baukis2.example.com/admin/login").to route_to(
      host: "baukis2.example.com",
      controller: "admin/sessions",
      action: "new"
    )
  end

  example "顧客トップページ" do
    expect(get: "http://example.com/mypage").to route_to(
      host: "example.com",
      controller: "customer/top",
      action: "index"
    )
  end

  example "ホスト名が対象外ならroutableではない" do
    expect(get: "http://foo.example.jp").not_to be_routable
  end

  example "存在しないパスならroutableではない" do
    expect(get: "http://baukis2.example.jp/xyz").not_to be_routable
  end
end

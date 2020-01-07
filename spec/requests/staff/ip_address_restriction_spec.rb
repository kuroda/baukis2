require "rails_helper"

describe "IPアドレスによるアクセス制限" do
  before do
    Rails.application.config.baukis2[:restrict_ip_addresses] = true
  end

  example "許可" do
    AllowedSource.create!(namespace: "staff", ip_address: "127.0.0.1")
    get staff_root_url
    expect(response.status).to eq(200)
  end

  example "拒否" do
    AllowedSource.create!(namespace: "staff", ip_address: "192.168.0.*")
    get staff_root_url
    expect(response.status).to eq(403)
  end
end
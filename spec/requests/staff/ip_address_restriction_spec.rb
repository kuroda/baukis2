require "rails_helper"

describe "IPアドレスによるアクセス制限" do
  let(:staff_member) { create(:staff_member) }

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

    expect { get staff_root_url }
      .to raise_error(ApplicationController::IpAddressRejected)
  end
end

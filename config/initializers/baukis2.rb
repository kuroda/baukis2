Rails.application.configure do 
  config.baukis2 = {
    staff: { host: "baukis2.example.com", path: "" },
    admin: { host: "baukis2.example.com", path: "admin" },
    customer: { host: "example.com", path: "mypage" },
    restrict_ip_addresses: ENV["RESTRICT_IP_ADDRESS"] == "1"
  }
end

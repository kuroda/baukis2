Rails.application.configure do 
  config.baukis2 = {
    staff: { host: "baukis2.example.com", path: "" },
    admin: { host: "baukis2.example.com", path: "admin" },
    customer: { host: "example.com", path: "mypage" }
  }
end

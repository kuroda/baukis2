FactoryBot.define do
  factory :home_address do
    postal_code { "1000000" }
    prefecture { "東京都" }
    city { "千代田区" }
    address1 { "試験1-1-1" }
    address2 { "" }
  end

  factory :work_address do
    company_name { "テスト" }
    division_name { "開発部" }
    postal_code { "1050000" }
    prefecture { "東京都" }
    city { "港区" }
    address1 { "試験1-1-1" }
    address2 { "" }
  end
end

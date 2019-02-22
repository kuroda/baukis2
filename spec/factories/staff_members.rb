FactoryBot.define do
  factory :staff_member do
    sequence(:email) { |n| "member#{n}@example.com" }
    family_name { "山田" }
    given_name { "太郎" }
    family_name_kana { "ヤマダ" }
    given_name_kana { "タロウ" }
    password { "pw" }
    start_date { 7.days.ago.to_date }
    end_date { nil }
    suspended { false }
  end
end

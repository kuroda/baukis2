FactoryBot.define do
  factory :customer do
    sequence(:email) { |n| "member#{n}@example.jp" }
    family_name { "山田" }
    given_name { "太郎" }
    family_name_kana { "ヤマダ" }
    given_name_kana { "タロウ" }
    password { "pw" }
    birthday { Date.new(1970, 1, 1) }
    gender { "male" }
    association :home_address, strategy: :build
    association :work_address, strategy: :build
  end
end

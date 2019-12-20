FactoryBot.define do
  factory :program do
    title { "Title" }
    description { "Description" }
    application_start_time { 5.days.ago.midnight }
    application_end_time { 2.days.from_now.midnight }
    min_number_of_participants { 5 }
    max_number_of_participants { 10 }
    registrant { create(:staff_member) }
  end
end

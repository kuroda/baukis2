class Customer < ApplicationRecord
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

  has_one :home_address, dependent: :destroy, autosave: true
  has_one :work_address, dependent: :destroy, autosave: true

  validates :gender, inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: ->(obj) { Date.today },
    allow_blank: true
  }
end

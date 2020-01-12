class Program < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :applicants, through: :entries, source: :customer
  belongs_to :registrant, class_name: "StaffMember"
end

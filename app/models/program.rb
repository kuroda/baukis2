class Program < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :applicants, through: :entries, source: :customer
  belongs_to :registrant, class_name: "StaffMember"

  scope :listing, -> {
    left_joins(:entries)
      .select("programs.*, COUNT(entries.id) AS number_of_applicants")
      .group("programs.id")
      .order(application_start_time: :desc)
      .includes(:registrant)
  }
end

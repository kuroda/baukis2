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

  attribute :application_start_date, :date, default: Date.today
  attribute :application_start_hour, :integer, default: 9
  attribute :application_start_minute, :integer, default: 0
  attribute :application_end_date, :date, default: Date.today
  attribute :application_end_hour, :integer, default: 17
  attribute :application_end_minute, :integer, default: 0

  def init_virtual_attributes
    if application_start_time
      self.application_start_date = application_start_time.to_date
      self.application_start_hour = application_start_time.hour
      self.application_start_minute = application_start_time.min
    end

    if application_end_time
      self.application_end_date = application_end_time.to_date
      self.application_end_hour = application_end_time.hour
      self.application_end_minute = application_end_time.min
    end
  end
end

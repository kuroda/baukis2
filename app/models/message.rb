class Message < ApplicationRecord
  belongs_to :customer
  belongs_to :staff_member, optional: true
  belongs_to :root, class_name: "Message", foreign_key: "root_id",
    optional: true
  belongs_to :parent, class_name: "Message", foreign_key: "parent_id",
    optional: true

  before_validation do
    if parent
      self.customer = parent.customer
      self.root = parent.root || root
    end
  end

  validates :subject, presence: true, length: { maximum: 80 }
  validates :body, presence: true, length: { maximum: 800 }

  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }
  scope :sorted, -> { order(created_at: :desc) }
end

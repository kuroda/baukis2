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
      self.root = parent.root || parent
    end
  end

  validates :subject, presence: true, length: { maximum: 80 }
  validates :body, presence: true, length: { maximum: 800 }

  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }
  scope :sorted, -> { order(created_at: :desc) }

  attr_accessor :child_nodes

  def tree
    return @tree if @tree
    r = root || self
    messages = Message.where(root_id: r.id).select(:id, :parent_id, :subject)
    @tree = SimpleTree.new(r, messages)
  end
end

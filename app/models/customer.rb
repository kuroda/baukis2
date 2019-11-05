class Customer < ApplicationRecord
  has_one :home_address, dependent: :destroy
  has_one :work_address, dependent: :destroy

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end

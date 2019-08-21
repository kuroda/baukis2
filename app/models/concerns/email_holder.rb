module EmailHolder
  extend ActiveSupport::Concern

  included do
    include StringNormalizer

    before_validation do
      self.email = normalize_as_email(email)
      self.email_for_index = email.downcase if email
    end

    validates :email, presence: true, "valid_email_2/email": true
    validates :email_for_index, uniqueness: { allow_blank: true }

    after_validation do
      if errors.include?(:email_for_index)
        errors.add(:email, :taken)
        errors.delete(:email_for_index)
      end
    end
  end
end

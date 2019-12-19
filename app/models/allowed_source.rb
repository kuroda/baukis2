class AllowedSource < ApplicationRecord
  attr_accessor :last_octet, :_destroy

  before_validation do
    if last_octet
      self.last_octet.strip!
      if last_octet == "*"
        self.octet4 = 0
        self.wildcard = true
      else
        self.octet4 = last_octet
      end
    end
  end

  validates :octet1, :octet2, :octet3, :octet4, presence: true,
    numericality: { only_integer: true, allow_blank: true },
    inclusion: { in: 0..255, allow_blank: true }
  validates :octet4,
    uniqueness: { scope: [ :octet1, :octet2, :octet3 ], allow_blank: true }
  validates :last_octet,
    inclusion: { in: (0..255).to_a.map(&:to_s) + [ "*" ], allow_blank: true }

  after_validation do
    if last_octet
      errors[:octet4].each do |message|
        errors.add(:last_octet, message)
      end
    end
  end

  def ip_address=(ip_address)
    octets = ip_address.split(".")
    self.octet1 = octets[0]
    self.octet2 = octets[1]
    self.octet3 = octets[2]

    if octets[3] == "*"
      self.octet4 = 0
      self.wildcard = true
    else
      self.octet4 = octets[3]
    end
  end

  class << self
    def include?(namespace, ip_address)
      return true if !Rails.application.config.baukis2[:restrict_ip_addresses]

      octets = ip_address.split(".")

      condition = %Q{
        octet1 = ? AND octet2 = ? AND octet3 = ?
        AND ((octet4 = ? AND wildcard = ?) OR wildcard = ?)
      }.gsub(/\s+/, " ").strip

      opts = [ condition, *octets, false, true ]
      where(namespace: namespace).where(opts).exists?
    end
  end
end

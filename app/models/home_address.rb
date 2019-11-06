class HomeAddress < Address
  validates :postal_code, :prefecture, :city, :address1, presence: true
  validates :company_name, :division_name, absence: true
end

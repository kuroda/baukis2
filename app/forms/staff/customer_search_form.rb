class Staff::CustomerSearchForm
  include ActiveModel::Model

  attr_accessor :family_name_kana, :given_name_kana,
    :birth_year, :birth_month, :birth_mday,
    :address_type, :prefecture, :city, :phone_number
end

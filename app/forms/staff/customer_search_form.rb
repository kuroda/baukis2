class Staff::CustomerSearchForm
  include ActiveModel::Model

  attr_accessor :family_name_kana, :given_name_kana,
    :birth_year, :birth_month, :birth_mday,
    :address_type, :prefecture, :city, :phone_number

  def search
    rel = Customer

    if family_name_kana.present?
      rel = rel.where(family_name_kana: family_name_kana)
    end

    if given_name_kana.present?
      rel = rel.where(given_name_kana: given_name_kana)
    end

    rel = rel.where(birth_year: birth_year) if birth_year.present?
    rel = rel.where(birth_month: birth_month) if birth_month.present?
    rel = rel.where(birth_mday: birth_mday) if birth_mday.present?

    if prefecture.present? || city.present?
      case address_type
      when "home"
        rel = rel.joins(:home_address)
      when "work"
        rel = rel.joins(:work_address)
      when ""
        rel = rel.joins(:addresses)
      else
        raise
      end

      if prefecture.present?
        rel = rel.where("addresses.prefecture" => prefecture)
      end

      rel = rel.where("addresses.city" => city) if city.present?
    end

    if phone_number.present?
      rel = rel.joins(:phones).where("phones.number_for_index" => phone_number)
    end

    rel = rel.distinct

    rel.order(:family_name_kana, :given_name_kana)
  end
end

class ConfirmingCustomerFormPresenter < ConfirmingUserFormPresenter
  def gender_field_block
    markup(:div, class: "input-block") do |m|
      m << decorated_label(:gender, "性別")
      m.div(object.gender == "male" ? "男性" : "⼥性", class: "field-value")
      m << hidden_field(:gender)
    end
  end
end

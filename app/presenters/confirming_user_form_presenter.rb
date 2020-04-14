class ConfirmingUserFormPresenter < ConfirmingFormPresenter
  def full_name_block(name1, name2, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(name1, label_text)
      m.div(object.send(name1) + " " + object.send(name2),
        class: "field-value")
      m << hidden_field(name1)
      m << hidden_field(name2)
    end
  end
end

class ProgramPresenter < ModelPresenter
  delegate :title, :description, to: :object
  delegate :number_with_delimiter, :current_customer, :button_to,
    to: :view_context

  def application_start_time
    object.application_start_time.strftime("%Y-%m-%d %H:%M")
  end

  def application_end_time
    object.application_end_time.strftime("%Y-%m-%d %H:%M")
  end

  def max_number_of_participants
    if object.max_number_of_participants
      number_with_delimiter(object.max_number_of_participants)
    end
  end

  def min_number_of_participants
    if object.min_number_of_participants
      number_with_delimiter(object.min_number_of_participants)
    end
  end

  def number_of_applicants
    number_with_delimiter(object[:number_of_applicants])
  end

  def registrant
    object.registrant.family_name + " " + object.registrant.given_name
  end

  def apply_or_cancel_button
    if entry = object.entries.where(customer_id: current_customer.id).first
      label_text = entry.canceled? ? "キャンセル済み" : "キャンセルする"
      button_to label_text, [ :cancel, :customer, object, entry ],
        disabled: entry.canceled?, method: :patch,
        data: { confirm: "本当にキャンセルしますか？" }
    else
      closed = object.application_end_time.try(:<, Time.current)
      label_text = closed ? "募集終了" : "申し込む"
      button_to label_text, [ :customer, object, :entries ],
        disabled: closed, method: :post,
        data: { confirm: "本当に申し込みますか？" }
    end
  end
end

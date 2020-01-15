class ProgramPresenter < ModelPresenter
  delegate :title, :description, to: :object
  delegate :number_with_delimiter, :button_to, :current_customer,
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
    if entry = object.entries.find_by(customer_id: current_customer.id)
      status = cancellation_status(entry)
      button_to cancel_button_label_text(status),
        [ :cancel, :customer, object, :entry ],
        disabled: status != :cancellable, method: :patch,
        data: { confirm: "本当にキャンセルしますか？" }
    else
      status = program_status
      button_to button_label_text(status), [ :customer, object, :entry ],
        disabled: status != :available, method: :post,
        data: { confirm: "本当に申し込みますか？" }
    end
  end

  private def program_status
    if object.application_end_time.try(:<, Time.current)
      :closed
    elsif object.max_number_of_participants.try(:<=, object.applicants.count)
      :full
    else
      :available
    end
  end

  private def button_label_text(status)
    case status
    when :closed
      "募集終了"
    when :full
      "満員"
    when :available
      "申し込む"
    end
  end

  private def cancellation_status(entry)
    if object.application_end_time.try(:<, Time.current)
      :closed
    elsif entry.canceled?
      :canceled
    else
      :cancellable
    end
  end

  private def cancel_button_label_text(status)
    case status
    when :closed
      "申し込み済み（キャンセル不可）"
    when :canceled
      "キャンセル済み"
    else
      "キャンセルする"
    end
  end
end

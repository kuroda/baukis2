class MessagePresenter < ModelPresenter
  delegate :subject, :body, to: :object
  
  def type
    case object
    when CustomerMessage
      "問い合わせ"
    when StaffMessage
      "返信"
    else
      raise
    end
  end

  def sender
    case object
    when CustomerMessage
      object.customer.family_name + " " + object.customer.given_name
    when StaffMessage
      object.staff_member.family_name + " " + object.staff_member.given_name
    else
      raise
    end
  end

  def receiver
    case object
    when CustomerMessage
      ""
    when StaffMessage
      object.customer.family_name + " " + object.customer.given_name
    else
      raise
    end
  end
  
  def truncated_subject
    view_context.truncate(subject, length: 20)
  end
  
  def created_at
    if object.created_at > Time.current.midnight
      object.created_at.strftime("%H:%M:%S")
    elsif object.created_at > 5.months.ago.beginning_of_month
      object.created_at.strftime("%m/%d %H:%M")
    else
      object.created_at.strftime("%Y/%m/%d %H:%M")
    end
  end
end
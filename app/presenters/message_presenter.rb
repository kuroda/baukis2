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
  
  def formatted_body
    ERB::Util.html_escape(body).gsub(/\n/, "<br>").html_safe
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

  def tree
    expand(object.tree.root)
  end

  private def expand(node)
    markup(:ul) do |m|
      m.li do
        if node.id == object.id
          m.strong(node.subject)
        else
          m << link_to(node.subject, view_context.staff_message_path(node))
        end
        node.child_nodes.each do |c|
          m << expand(c)
        end
      end
    end
  end
end
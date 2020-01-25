module StaffHelper
  include HtmlBuilder

  def number_of_unprocessed_messages
    markup do |m|
      m.a(href: inbound_staff_messages_path) do
        m << "新規問い合わせ"
        if (c = CustomerMessage.unprocessed.count) > 0
          anchor_text = "(#{c})"
        else
          anchor_text = ""
        end
        m.span(
        anchor_text,
        id: "number-of-unprocessed-messages",
        "data-path" => count_staff_messages_path
        )
      end
    end
  end
end
class FormPresenter
  include HtmlBuilder

  attr_reader :form_builder, :view_context
  delegate :label, :text_field, :date_field, :password_field,
    :check_box, :radio_button, :text_area, :object, to: :form_builder

  def initialize(form_builder, view_context)
    @form_builder = form_builder
    @view_context = view_context
  end

  def notes
    markup(:div, class: "notes") do |m|
      m.span "*", class: "mark"
      m.text "印の付いた項目は入力必須です。"
    end
  end

  def text_field_block(name, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(name, label_text, options)
      m << text_field(name, options)
      if options[:maxlength]
        m.span "（#{options[:maxlength]}文字以内）", class: "instruction"
      end
      m << error_messages_for(name)
    end
  end

  def number_field_block(name, label_text, options = {})
    markup(:div) do |m|
      m << decorated_label(name, label_text, options)
      m << form_builder.number_field(name, options)
      if options[:max]
        max = view_context.number_with_delimiter(options[:max].to_i)
        m.span "（最大値: #{max}）", class: "instruction"
      end
      m << error_messages_for(name)
    end
  end

  def password_field_block(name, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(name, label_text, options)
      m << password_field(name, options)
      m << error_messages_for(name)
    end
  end

  def date_field_block(name, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(name, label_text, options)
      m << date_field(name, options)
      m << error_messages_for(name)
    end
  end

  def drop_down_list_block(name, label_text, choices, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(name, label_text, options)
      m << form_builder.select(name, choices, { include_blank: true }, options)
      m << error_messages_for(name)
    end
  end

  def error_messages_for(name)
    markup do |m|
      object.errors.full_messages_for(name).each do |message|
        m.div(class: "error-message") do |m|
          m.text message
        end
      end
    end
  end

  def decorated_label(name, label_text, options = {})
    label(name, label_text, class: options[:required] ? "required" : nil)
  end
end

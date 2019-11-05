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
    end
  end

  def password_field_block(name, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(name, label_text, options)
      m << password_field(name, options)
    end
  end

  def date_field_block(name, label_text, options = {})
    markup(:div, class: "input-block") do |m|
      m << decorated_label(name, label_text, options)
      m << date_field(name, options)
    end
  end

  private def decorated_label(name, label_text, options = {})
    label(name, label_text, class: options[:required] ? "required" : nil)
  end
end

class ProgramFormPresenter < FormPresenter
  def description
    markup(:div, class: "input-block") do |m|
      m << decorated_label(:description, "詳細", required: true)
      m << text_area(:description, rows: 6, style: "width: 454px")
      m.span "（800⽂字以内）", class: "instruction", style: "float: right"
      m << error_messages_for(:description)
    end
  end

  def datetime_field_block(name, label_text, options = {})
    instruction = options.delete(:instruction)
    if object.errors.include?("#{name}_time".to_sym)
      html_class = "input-block with-errors"
    else
      html_class = "input-block"
    end
    markup(:div, class: html_class) do |m|
      m << decorated_label("#{name}_date", label_text, options)
      m << date_field("#{name}_date", options)
      m << form_builder.select("#{name}_hour", hour_options)
      m << ":"
      m << form_builder.select("#{name}_minute", minute_options)
      m.span "（#{instruction}）", class: "instruction" if instruction
      m << error_messages_for("#{name}_time".to_sym)
      m << error_messages_for("#{name}_date".to_sym)
    end
  end

  private def hour_options
    (0..23).map { |h| [ "%02d" % h, h ] }
  end

  private def minute_options
    (0..11)
      .map { |n| n * 5}
      .map { |m| [ "%02d" % m, m ] }
  end
end
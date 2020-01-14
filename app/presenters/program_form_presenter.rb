class ProgramFormPresenter < FormPresenter
  def description
    markup(:div, class: "input-block") do |m|
      m << decorated_label(:description, "詳細", required: true)
      m << text_area(:description, rows: 6, style: "width: 454px")
      m.span "（800文字以内）", class: "instruction", style: "float: right"
    end
  end

  def datetime_field_block(name, label_text, options = {})
    instruction = options.delete(:instruction)
    markup(:div, class: "input-block") do |m|
      m << decorated_label("#{name}_date", label_text, options)
      m << date_field("#{name}_date", options)
      m << form_builder.select("#{name}_hour", hour_options)
      m << ":"
      m << form_builder.select("#{name}_minute", minute_options)
      m.span "（#{instruction}）", class: "instruction" if instruction
    end
  end

  private def hour_options
    (0..23).map { |h| [ "%02d" % h, h ] }
  end

  private def minute_options
    (0..11)
      .map { |n| n * 5 }
      .map { |m| [ "%02d" % m, m ] }
  end
end

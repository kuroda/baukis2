module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} - Baukis2"
    else
      "Baukis2"
    end
  end
end

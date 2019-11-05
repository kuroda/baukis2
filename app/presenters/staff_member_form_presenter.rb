class StraffMemberFormPresenter < UserFormPresenter
  def suspended_check_box
    markup(:div, class: "input-block") do |m|
      m << check_box(:suspended)
      m << label(:suspended, "アカウント停止")
    end
  end
end

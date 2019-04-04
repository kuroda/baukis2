class Staff::Base < ApplicationController
  before_action :authorize
  before_action :check_account

  private def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||=
        StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  helper_method :current_staff_member

  private def authorize
    unless current_staff_member
      flash.alert = "職員としてログインしてください。"
      redirect_to :staff_login
    end
  end

  private def check_account
    if current_staff_member && !current_staff_member.active?
      session.delete(:staff_member_id)
      flash.alert = "アカウントが無効になりました。"
      redirect_to :staff_root
    end
  end
end

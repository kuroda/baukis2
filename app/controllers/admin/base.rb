class Admin::Base < ApplicationController
  before_action :authorize
  before_action :check_account
  before_action :check_timeout

  private def current_administrator
    if session[:administrator_id]
      @current_administrator ||=
        Administrator.find_by(id: session[:administrator_id])
    end
  end

  helper_method :current_administrator

  private def authorize
    unless current_administrator
      flash.alert = "管理者としてログインしてください。"
      redirect_to :admin_login
    end
  end

  private def check_account
    if current_administrator && current_administrator.suspended?
      session.delete(:administrator_id)
      flash.alert = "アカウントが無効になりました。"
      redirect_to :admin_root
    end
  end

  TIMEOUT = 60.minutes

  private def check_timeout
    if current_administrator
      last_access_time = session[:admin_last_access_time]
      if last_access_time && last_access_time >= TIMEOUT.ago
        session[:admin_last_access_time] = Time.current
      else
        session.delete(:administrator_id)
        flash.alert = "セッションがタイムアウトしました。"
        redirect_to :admin_login
      end
    end
  end
end

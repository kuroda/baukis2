class Staff::AjaxController < ApplicationController
  before_action :check_source_ip_address
  before_action :authorize
  before_action :check_timeout
  before_action :reject_non_xhr

  # GET
  def message_count
    render plain: CustomerMessage.unprocessed.count
  end

  private def check_source_ip_address
    unless AllowedSource.include?("staff", request.ip)
      render plain: "Forbidden", status: 403
    end
  end

  private def current_staff_member
    if session[:staff_member_id]
      StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  private def authorize
    unless current_staff_member && current_staff_member.active?
      render plain: "Forbidden", status: 403
    end
  end

  private def check_timeout
    unless session[:last_access_time] &&
           session[:last_access_time] >= Staff::Base::TIMEOUT.ago
      session.delete(:staff_member_id)
      render plain: "Forbidden", status: 403
    end
  end
end

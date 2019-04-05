module SessionHelpers
  def login_as(user)
    case user
    when StaffMember
      post staff_session_url, params: {
        staff_login_form: { email: staff_member.email, password: "pw" }
      }
    when Administrator
      post admin_session_url, params: {
        admin_login_form: { email: administrator.email, password: "pw" }
      }
    end
  end
end

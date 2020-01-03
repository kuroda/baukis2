class Customer::Base < ApplicationController
  before_action :authorize

  private def current_customer
    if session[:customer_id]
      @current_customer ||=
      Customer.find_by(id: session[:customer_id])
    end
  end

  helper_method :current_customer
  
  private def authorize
    unless current_customer
      flash.alert = "ログインしてください。"
      redirect_to :customer_login
    end
  end
end
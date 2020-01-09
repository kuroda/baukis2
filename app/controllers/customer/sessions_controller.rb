class Customer::SessionsController < Customer::Base
  skip_before_action :authorize

  def new
    if current_customer
      redirect_to :customer_root
    else
      @form = Customer::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Customer::LoginForm.new(login_form_params)
    if @form.email.present?
      customer =
        Customer.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    if Customer::Authenticator.new(customer).authenticate(@form.password)
      session[:customer_id] = customer.id
      flash.notice = "ログインしました。"
      redirect_to :customer_root
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  private def login_form_params
    params.require(:customer_login_form).permit(:email, :password)
  end

  def destroy
    session.delete(:customer_id)
    flash.notice = "ログアウトしました。"
    redirect_to :customer_root
  end
end

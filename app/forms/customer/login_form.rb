class Customer::LoginForm
  include ActiveModel::Model

  attr_accessor :email, :password, :remember_me

  def remember_me?
    remember_me == "1"
  end
end

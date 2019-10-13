class Staff::ChangePasswordForm 
  include ActiveModel::Model

  attr_accessor :object, :current_password, :new_password,
    :new_password_confirmation

  def save
    object.password = new_password
    object.save!
  end
end

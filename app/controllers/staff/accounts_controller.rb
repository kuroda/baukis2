class Staff::AccountsController < Staff::Base
  def show
    @staff_member = current_staff_member
  end

  def edit
    @staff_member = current_staff_member
  end

  def update
    @staff_member = current_staff_member
    @staff_member.assign_attributes(staff_member_params)
    if @staff_member.save
      flash.notice = "アカウント情報を更新しました。"
      # Rails 6.0.0.beta2 で allow_other_host オプションは不要となる。
      redirect_to :staff_account, allow_other_host: true
    else
      render action: "edit"
    end
  end

  private def staff_member_params
    params.require(:staff_member).permit(
      :email, :family_name, :given_name,
      :family_name_kana, :given_name_kana
    )
  end
end

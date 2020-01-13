class Staff::EntriesController < Staff::Base
  def update_all
    entries_form = Staff::EntriesForm.new(Program.find(params[:program_id]))
    entries_form.update_all(params)
    flash.notice = "プログラム申し込みのフラグを更新しました。"
    redirect_to :staff_programs
  end
end

class Staff::ProgramsController < Staff::Base
  def index
    @programs = Program.listing.page(params[:page])
  end

  def show
    @program = Program.listing.find(params[:id])
  end

  def new
    @program = Program.new
  end

  def edit
    @program = Program.find(params[:id])
    @program.init_virtual_attributes
  end

  def create
    @program = Program.new
    @program.assign_attributes(program_params)
    @program.registrant = current_staff_member
    if @program.save
      flash.notice = "プログラムを登録しました。"
      redirect_to action: "index"
    else
      flash.now.alert = "⼊⼒に誤りがあります。"
      render action: "new"
    end
  end

  def update
    @program = Program.find(params[:id])
    @program.assign_attributes(program_params)
    if @program.save
      flash.notice = "プログラムを更新しました。"
      redirect_to action: "index"
    else
      flash.now.alert = "⼊⼒に誤りがあります。"
      render action: "edit"
    end
  end

  private def program_params
    params.require(:program).permit([
      :title,
      :application_start_date,
      :application_start_hour,
      :application_start_minute,
      :application_end_date,
      :application_end_hour,
      :application_end_minute,
      :min_number_of_participants,
      :max_number_of_participants,
      :description
    ])
  end

  def destroy
    program = Program.find(params[:id])
    program.destroy!
    flash.notice = "プログラムを削除しました。"
    redirect_to :staff_programs
  end
end

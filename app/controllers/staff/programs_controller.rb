class Staff::ProgramsController < Staff::Base
  def index
    @programs = Program.order(application_start_time: :desc)
      .page(params[:page])
  end

  def show
    @program = Program.find(params[:id])
  end
end

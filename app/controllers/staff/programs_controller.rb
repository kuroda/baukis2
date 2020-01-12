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
end

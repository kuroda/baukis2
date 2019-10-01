class Staff::TopController < Staff::Base
  def index
    render action: "index"
  end
end

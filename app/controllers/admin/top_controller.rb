class Admin::TopController < Admin::Base
  def index
    render action: "index"
  end
end

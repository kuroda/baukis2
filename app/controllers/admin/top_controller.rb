class Admin::TopController < ApplicationController
  def index
    if current_administrator
      render action: "dashboard"
    else
      render action: "index"
    end
  end
end

class Customer::TopController < ApplicationController
  def index
    raise ActiveRecord::RecordNotFound
    render action: "index"
  end
end

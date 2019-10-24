class Customer::TopController < ApplicationController
  def index
    render action: "index"
  end
end

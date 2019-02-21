class ErrorsController < ApplicationController
  layout "staff"

  TEMPLATES = {
    404 => :not_found,
    422 => :unprocessable_entity,
    500 => :internal_server_error
  }

  def show
    status = request.path_info[1..-1].to_i
    status = 500 unless TEMPLATES[status]
    render action: TEMPLATES[status], status: status
  end
end

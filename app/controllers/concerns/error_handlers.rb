module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :rescue400
    rescue_from ApplicationController::Forbidden, with: :rescue403
    rescue_from ApplicationController::IpAddressRejected, with: :rescue403
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private def rescue400(e)
    render "errors/bad_request", status: 400
  end

  private def rescue403(e)
    render "errors/forbidden", status: 403
  end

  private def rescue404(e)
    render "errors/not_found", status: 404
  end
end

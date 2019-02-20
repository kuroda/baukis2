Rails.application.config.exceptions_app = lambda do |env|
  request = ActionDispatch::Request.new(env)
  status = request.path_info[1..-1].to_i

  action =
    case status
      when 404; :not_found
      when 422; :unprocessable_entity
      else; :internal_server_error
    end

  ErrorsController.action(action).call(env)
end

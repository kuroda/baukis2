Rails.application.configure do
  config.exceptions_app = ->(env) do
    request = ActionDispatch::Request.new(env)

    action =
      case request.path_info
      when "/404"; :not_found
      when "/422"; :unprocessable_entity
      else; :internal_server_error
      end

    ErrorsController.action(action).call(env)
  end
end

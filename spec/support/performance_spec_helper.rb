module PerformanceSpecHelper
  def write_to_performance_log(example, elapsed)
    @logger ||= ActiveSupport::Logger.new(
      Rails.root.join("log", "performance_spec.log"))
    message = example.metadata[:example_group][:full_description] + "/" +
      example.description
    @logger.info sprintf("%s -- Elapsed: %2.3f seconds", message, elapsed)
  end
end

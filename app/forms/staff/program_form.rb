class Staff::ProgramForm
  include ActiveModel::Model

  attr_accessor :program,
    :application_start_date, :application_start_hour, :application_start_minute,
    :application_end_date, :application_end_hour, :application_end_minute
  delegate :persisted?, :save, to: :program

  def initialize(program = nil)
    @program = program
    @program ||= Program.new

    if @program.application_start_time
      self.application_start_date =
        @program.application_start_time.to_date.to_s
      self.application_start_hour =
        sprintf("%02d", @program.application_start_time.hour)
      self.application_start_minute =
        sprintf("%02d", @program.application_start_time.min)
    else
      self.application_start_hour = "09"
      self.application_start_minute = "00"
    end

    if @program.application_end_time
      self.application_end_date =
        @program.application_end_time.to_date.to_s
      self.application_end_hour =
        sprintf("%02d", @program.application_end_time.hour)
      self.application_end_minute =
        sprintf("%02d", @program.application_end_time.min)
    else
      self.application_end_hour = "17"
      self.application_end_minute = "00"
    end
  end
end

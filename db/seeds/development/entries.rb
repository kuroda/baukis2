programs = Program.where(["application_start_time < ?", Time.current])
programs.order(id: :desc).limit(3).each_with_index do |p, i|
  Customer.order(:id).limit((i + 1) * 5).each do |c|
    p.applicants << c
  end
end
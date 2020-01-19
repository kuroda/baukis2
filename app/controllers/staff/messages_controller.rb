class Staff::MessagesController < Staff::Base
  before_action :reject_non_xhr, only: [ :count ]
  
  # GET
  def count
    render plain: CustomerMessage.unprocessed.count
  end
end

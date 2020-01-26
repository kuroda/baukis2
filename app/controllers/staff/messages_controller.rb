class Staff::MessagesController < Staff::Base
  before_action :reject_non_xhr, only: [ :count ]
  
  def index
    @messages = Message.not_deleted.sorted.page(params[:page])
  end
  
  # GET
  def inbound
    @messages = CustomerMessage.not_deleted.sorted.page(params[:page])
    render action: "index"
  end
  
  # GET
  def outbound
    @messages = StaffMessage.not_deleted.sorted.page(params[:page])
    render action: "index"
  end
  
  # GET
  def deleted
    @messages = Message.deleted.sorted.page(params[:page])
    render action: "index"
  end

  # GET
  def count
    render plain: CustomerMessage.unprocessed.count
  end

  def show
    @message = Message.find(params[:id])
  end

  def destroy
    message = CustomerMessage.find(params[:id])
    message.update_column(:deleted, true)
    flash.notice = "問い合わせを削除しました。"
    redirect_back(fallback_location: :staff_root)
  end

  # POST/DELETE
  def tag
    message = CustomerMessage.find(params[:id])
    if request.post?
      message.add_tag(params[:label])
    elsif request.delete?
      message.remove_tag(params[:label])
    else
      raise
    end
    render plain: "OK"
  end
end

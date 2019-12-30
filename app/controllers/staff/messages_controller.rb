class Staff::MessagesController <  Staff::Base
  before_action :reject_non_xhr, only: [ :count ]

  def index
    @messages = Message.where(deleted: false).page(params[:page])
  end

  # GET
  def inbound
    @messages = CustomerMessage.where(deleted: false).page(params[:page])
    render action: "index"
  end

  # GET
  def outbound
    @messages = StaffMessage.where(deleted: false).page(params[:page])
    render action: "index"
  end

  # GET
  def deleted
    @messages = Message.where(deleted: true).page(params[:page])
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
end

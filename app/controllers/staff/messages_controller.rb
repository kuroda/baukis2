class Staff::MessagesController < Staff::Base
  def index
    @messages = Message.not_deleted.sorted.page(params[:page])
      .tagged_as(params[:tag_id])
  end

  # GET
  def inbound
    @messages = CustomerMessage.not_deleted.sorted.page(params[:page])
      .tagged_as(params[:tag_id])
    render action: "index"
  end

  # GET
  def outbound
    @messages = StaffMessage.not_deleted.sorted.page(params[:page])
      .tagged_as(params[:tag_id])
    render action: "index"
  end

  # GET
  def deleted
    @messages = Message.deleted.sorted.page(params[:page])
      .tagged_as(params[:tag_id])
    render action: "index"
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

class Customer::MessagesController < Customer::Base
  def index
    @messages = current_customer.inbound_messages.where(discarded: false)
      .sorted.page(params[:page])
  end

  def show
    @message = current_customer.inbound_messages.find(params[:id])
  end

  def new
    @message = CustomerMessage.new
  end

  # POST
  def confirm
    @message = CustomerMessage.new(customer_message_params)
    @message.customer = current_customer
    if @message.valid?
      render action: "confirm"
    else
      flash.now.alert = "⼊⼒に誤りがあります。"
      render action: "new"
    end
  end

  def create
    @message = CustomerMessage.new(customer_message_params)
    if params[:commit]
      @message.customer = current_customer
      if @message.save
        flash.notice = "問い合わせを送信しました。"
        redirect_to :customer_root
      else
        flash.now.alert = "⼊⼒に誤りがあります。"
        render action: "new"
      end
    else
      render action: "new"
    end
  end

  private def customer_message_params
    params.require(:customer_message).permit(:subject, :body)
  end

  def destroy
    message = current_customer.inbound_messages.find(params[:id])
    message.update_column(:discarded, true)
    flash.notice = "メッセージを削除しました。"
    redirect_back(fallback_location: :customer_messages)
  end
end

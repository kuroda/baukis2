class Customer::EntriesController < Customer::Base
  def create
    program = Program.published.find(params[:program_id])
    case Customer::EntryAcceptor.new(current_customer).accept(program)
    when :accepted
      flash.notice = "プログラムに申し込みました。"
    when :full
      flash.alert = "プログラムへの申込者数が上限に達しました。"
    when :closed
      flash.alert = "プログラムの申し込み期間が終了しました。"
    end
    redirect_to [ :customer, program ]
  end

  # PATCH
  def cancel
    program = Program.published.find(params[:program_id])
    if program.application_end_time.try(:<, Time.current)
      flash.alert = "プログラムへの申し込みをキャンセルできません（受付期間終了）。"
    else
      entry = program.entries.find_by!(customer_id: current_customer.id)
      entry.update_column(:canceled, true)
      flash.notice = "プログラムへの申し込みをキャンセルしました。"
    end
    redirect_to [ :customer, program ]
  end
end

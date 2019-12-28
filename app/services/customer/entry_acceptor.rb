class Customer::EntryAcceptor
  def initialize(customer)
    @customer = customer
  end

  def accept(program)
    if max = program.max_number_of_participants
      if program.entries.where(canceled: false).count < max
        program.entries.create!(customer: @customer)
        return :accepted
      else
        return :full
      end
    else
      program.entries.create!(customer: @customer)
      return :accepted
    end
  end
end

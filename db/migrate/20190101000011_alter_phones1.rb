class AlterPhones1 < ActiveRecord::Migration[6.0]
  def change
    add_index :phones, "RIGHT(number_for_index, 4)"
  end
end

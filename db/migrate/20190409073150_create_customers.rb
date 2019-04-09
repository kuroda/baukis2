class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|

      t.timestamps
    end
  end
end

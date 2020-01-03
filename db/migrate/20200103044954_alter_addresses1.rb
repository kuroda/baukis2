class AlterAddresses1 < ActiveRecord::Migration[6.0]
  def change
    add_index :addresses, [ :type, :prefecture, :city ]
    add_index :addresses, [ :type, :city ]
    add_index :addresses, [ :prefecture, :city ]
    add_index :addresses, :city
  end
end

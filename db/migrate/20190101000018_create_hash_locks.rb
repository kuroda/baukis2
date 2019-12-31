class CreateHashLocks < ActiveRecord::Migration[6.0]
  def change
    create_table :hash_locks do |t|
      t.string :table, null: false
      t.string :column, null: false
      t.string :key, null: false

      t.timestamps
    end

    add_index :hash_locks, [ :table, :column, :key ], unique: true
  end
end

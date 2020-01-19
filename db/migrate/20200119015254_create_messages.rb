class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :customer, null: false                 # 顧客への外部キー
      t.references :staff_member                          # 職員への外部キー
      t.integer :root_id                                  # Messageへの外部キー
      t.integer :parent_id                                # Messageへの外部キー
      t.string :type, null: false                         # 継承カラム
      t.string :status, null: false, default: "new"       # 状態（職員向け）
      t.string :subject, null: false                      # 件名
      t.text :body                                        # 本⽂
      t.text :remarks                                     # 備考（職員向け）
      t.boolean :discarded, null: false, default: false   # 顧客側の削除フラグ
      t.boolean :deleted, null: false, default: false     # 職員側の削除フラグ

      t.timestamps
    end

    add_index :messages, [ :type, :customer_id ]
    add_index :messages, [ :customer_id, :discarded, :created_at ]
    add_index :messages, [ :type, :staff_member_id ]
    add_index :messages, [ :customer_id, :deleted, :created_at ]
    add_index :messages, [ :customer_id, :deleted, :status, :created_at ],
      name: "index_messages_on_c_d_s_c"
    add_index :messages, [ :root_id, :deleted, :created_at ]
    add_foreign_key :messages, :customers
    add_foreign_key :messages, :staff_members
    add_foreign_key :messages, :messages, column: "root_id"
    add_foreign_key :messages, :messages, column: "parent_id"
  end
end

class CreateStaffEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :staff_events do |t|
      t.references :staff_member, null: false, index: false, foreign_key: true
          # 職員レコードへの外部キー
      t.string :type, null: false # イベントタイプ
      t.datetime :created_at, null: false # 発生時刻
    end

    add_index :staff_events, :created_at
    add_index :staff_events, [ :staff_member_id, :created_at ]
  end
end

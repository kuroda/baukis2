class CreateStaffMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :staff_members do |t|
      t.string :email, null: false                      # メールアドレス
      t.string :email_for_index, null: false            # 索引用メールアドレス
      t.string :family_name, null: false                # 姓
      t.string :given_name, null: false                 # 名
      t.string :family_name_kana, null: false           # 姓（カナ）
      t.string :given_name_kana, null: false            # 名（カナ）
      t.string :hashed_password                         # パスワード
      t.date :start_date, null: false                   # 入社日
      t.date :end_date                                  # 退職日
      t.boolean :suspended, null: false, default: false # 停止フラグ

      t.timestamps
    end

    add_index :staff_members, :email_for_index, unique: true
    add_index :staff_members, [:family_name_kana, :given_name_kana]
  end
end

class CreateAdministrators < ActiveRecord::Migration[6.0]
  def change
    create_table :administrators do |t|
      t.string :email, null: false                      # メールアドレス
      t.string :email_for_index, null: false            # 索引用メールアドレス
      t.string :hashed_password                         # パスワード
      t.boolean :suspended, null: false, default: false # 停止フラグ

      t.timestamps
    end

    add_index :administrators, :email_for_index, unique: true
  end
end

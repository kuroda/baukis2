class CreatePrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :programs do |t|
      t.integer :registrant_id, null: false # 登録職員（外部キー）
      t.string :title, null: false # タイトル
      t.text :description # 説明
      t.datetime :application_start_time, null: false # 申し込み開始⽇時
      t.datetime :application_end_time, null: false # 申し込み終了⽇時
      t.integer :min_number_of_participants # 最⼩参加者数
      t.integer :max_number_of_participants # 最⼤参加者数

      t.timestamps
    end

    add_index :programs, :registrant_id
    add_index :programs, :application_start_time
    add_foreign_key :programs, :staff_members, column: "registrant_id"
  end
end

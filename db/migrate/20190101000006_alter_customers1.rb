class AlterCustomers1 < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :birth_year, :integer
    add_column :customers, :birth_month, :integer
    add_column :customers, :birth_mday, :integer

    add_index :customers, [ :birth_year, :birth_month, :birth_mday ]
    add_index :customers, [ :birth_month, :birth_mday ]
    add_index :customers, :given_name_kana
    add_index :customers, [ :birth_year, :family_name_kana, :given_name_kana ],
      name: "index_customers_on_birth_year_and_furigana"
    add_index :customers, [ :birth_year, :given_name_kana ]
    add_index :customers,
      [ :birth_month, :family_name_kana, :given_name_kana ],
      name: "index_customers_on_birth_month_and_furigana"
    add_index :customers, [ :birth_month, :given_name_kana ]
    add_index :customers, [ :birth_mday, :family_name_kana, :given_name_kana ],
      name: "index_customers_on_birth_mday_and_furigana"
    add_index :customers, [ :birth_mday, :given_name_kana ]
  end
end

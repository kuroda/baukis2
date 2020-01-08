class CreateAllowedSources < ActiveRecord::Migration[6.0]
  def change
    create_table :allowed_sources do |t|
      t.string :namespace, null: false
      t.integer :octet1, null: false
      t.integer :octet2, null: false
      t.integer :octet3, null: false
      t.integer :octet4, null: false
      t.boolean :wildcard, null: false, default: false

      t.timestamps
    end

    add_index :allowed_sources,
      [ :namespace, :octet1, :octet2, :octet3, :octet4 ], unique: true,
      name: "index_allowed_sources_on_namespace_and_octets"
  end
end

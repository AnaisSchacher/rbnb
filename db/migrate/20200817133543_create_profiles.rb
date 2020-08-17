class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :address
      t.boolean :available
      t.string :category
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end

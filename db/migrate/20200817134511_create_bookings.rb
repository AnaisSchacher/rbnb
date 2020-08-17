class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :price
      t.boolean :accepted

      t.timestamps
    end
  end
end

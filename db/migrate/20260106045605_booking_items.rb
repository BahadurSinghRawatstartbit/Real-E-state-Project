class BookingItems < ActiveRecord::Migration[6.1]
  def change
    create_table :booking_items do |t|
      t.references :book, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.references :variant, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end

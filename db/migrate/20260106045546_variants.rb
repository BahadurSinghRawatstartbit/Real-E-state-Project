class Variants < ActiveRecord::Migration[6.1]
  def change
    create_table :variants do |t|
      t.references :property, null: false, foreign_key: true
      t.string :size
      t.integer :bhk
      t.integer :floor
      t.integer :price

      t.timestamps
    end
  end
end

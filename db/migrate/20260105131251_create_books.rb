class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :discount
      t.string :status
      t.integer :total_amount

      t.timestamps
    end
  end
  
end

class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :status
      t.text :description
      t.string :address
      t.string :phonenumber
      t.date :soldate
      t.date :completiondate
      t.boolean :is_featureptoduct

      t.timestamps
    end
  end
end

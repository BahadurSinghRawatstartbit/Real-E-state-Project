class Adddiscountratting < ActiveRecord::Migration[6.1]
  def change
    add_column :properties ,:discounts ,:integer
    add_column :properties, :rating ,:integer
  end
end

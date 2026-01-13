class AddColumnNameToTableName < ActiveRecord::Migration[6.1]
  def change
    add_column :properties, :bedroom, :string
    add_column :properties, :bathroom, :string
    add_column :properties, :gerage, :string
    add_column :properties, :area, :string
    add_column :properties, :size, :string
    add_column :properties, :price, :string
  end
end

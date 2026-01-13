class AddPropertyColumn < ActiveRecord::Migration[6.1]
  def change
    
    add_column :properties, :swimmingpool, :boolean
    add_column :properties, :laundryroom, :boolean
    add_column :properties, :twostories, :boolean
    add_column :properties, :energencyexit, :boolean
    add_column :properties, :fireplace, :boolean
    add_column :properties, :jogpath, :boolean
    add_column :properties, :ceilings, :boolean
    add_column :properties, :dualsinks, :boolean
    add_column :properties, :videoone, :string
    add_column :properties, :videotwo, :string
    add_column :properties, :videothree, :string
  end
end

class RenameIsFeatureptoductToIsFeaturedProduct < ActiveRecord::Migration[6.1]
  def change
    rename_column :properties, :is_featureptoduct, :is_featured_product  
  end
end

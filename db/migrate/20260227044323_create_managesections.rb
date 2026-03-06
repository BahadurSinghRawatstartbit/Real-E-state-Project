class CreateManagesections < ActiveRecord::Migration[6.1]
  def change
    create_table :managesections do |t|
      t.string :section_type, null: false # e.g., 'hero', 'contact', 'about'
      t.string :title
      t.string :subtitle
      t.jsonb  :content, default: {}    # Store txt1, links, etc. here
      t.jsonb  :contact_info, default: {} # Store phone, email, social here
      t.boolean :active, default: true
      t.timestamps
    end
    add_index :managesections, :section_type
    add_index :managesections, :active
  end
  
end


    

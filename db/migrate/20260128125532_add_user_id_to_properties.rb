class AddUserIdToProperties < ActiveRecord::Migration[6.1]
  def change
    add_reference :properties, :user, null: true, foreign_key: true
  end
end

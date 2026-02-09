class AddStripeSessionIdToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :stripe_session_id, :string
  end
end

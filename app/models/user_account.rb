class UserAccount < ApplicationRecord
  belongs_to :user

  validates :provider, :provider_account_id, presence: true
  validates :provider_account_id, uniqueness: { scope: :provider }
  def expired?
    expires_at < Time.zone.now
  end
end

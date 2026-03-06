class Contact < ApplicationRecord
  belongs_to :user
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  validates :message, presence: true
  validates :subject, presence: true
  
end

class User < ApplicationRecord
  before_save { self.email = email.downcase }
   has_secure_password
  has_many :properties, foreign_key: :user_id, dependent: :destroy
  has_many :books, foreign_key: :user_id, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :wishlist_properties, through: :wishlists, source: :property

  has_many :booking_items, through: :books
  validates :name, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { minimum: 3, maximum: 25 }
  
  # VALID_PASSWORD_REGX= /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$).{8,20}$/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_NUMBER_REGEX = /\A\d{3}[-.\s]?\d{3}[-.\s]?\d{4}\z/
  

  # PASSWORD_FORMAT = /\A
  #   (?=.{8,})          
  #   (?=.*\d)           
  #   (?=.*[a-z])        
  #   (?=.*[A-Z])        
  #   (?=.*[[:^alnum:]]) 
  # \z/x
 
  validates :email, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { maximum: 105 },
                      format: { with: VALID_EMAIL_REGEX }
  validates :mobilenumber, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX }
#   validates :password_digest, format: { with: PASSWORD_FORMAT }, on: :create
# validates :password_digest, format: { with: PASSWORD_FORMAT }, allow_nil: true, on: :update
end


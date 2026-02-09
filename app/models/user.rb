class User < ApplicationRecord
  rolify   
  after_create :assign_default_role
  before_save { self.email = email.downcase }
  has_secure_password
  has_many :properties, foreign_key: :user_id, dependent: :destroy
  has_many :books, foreign_key: :user_id, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :wishlist_properties, through: :wishlists, source: :property
  has_many :user_accounts, dependent: :destroy
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
  validates :mobilenumber, allow_blank: true, format: { with: VALID_PHONE_NUMBER_REGEX }
#   validates :password_digest, format: { with: PASSWORD_FORMAT }, on: :create
# validates :password_digest, format: { with: PASSWORD_FORMAT }, allow_nil: true, on: :update
# 


  

  def admin?
    has_role?(:admin)
  end

  def agent?
    has_role?(:agent)
  end

  def newuser?
    has_role?(:newuser)
  end

  def assign_role(role_name)
    add_role(role_name.to_sym) unless has_role?(role_name.to_sym)
  end

  def remove_user_role(role_name)
    remove_role(role_name.to_sym) if has_role?(role_name.to_sym)
  end

  def reset_roles!
    roles.destroy_all
  end
 


  def assign_default_role
    
    self.add_role(:newuser) if self.roles.blank?
  end

  
end


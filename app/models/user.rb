# == Schema Information
# Schema version: 20101114124029
#
# Table name: users
#
#  id          :integer(4)      not null, primary key
#  last_name   :string(255)
#  first_name  :string(255)
#  email       :string(255)
#  nationality :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :last_name, :first_name, :email, :nationality, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #validations
  validates :last_name, :presence   => true,
                        :length     => { :maximum => 50 }
  validates :first_name, :presence  => true,
                        :length     => { :maximum => 50 }
  validates :email, :presence       => true, 
                        :format     => { :with => email_regex }, 
                        :uniqueness => { :case_sensitive => false }
  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password,  :presence     => true,
                        :confirmation => true,
                        :length       => { :within => 6..40 }
                        
  #validates nationality, :presence => true
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  
  private
    
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

  
end

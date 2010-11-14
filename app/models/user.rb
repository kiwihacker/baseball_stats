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
  attr_accessible :last_name, :first_name, :email, :nationality
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #validations
  validates :last_name, :presence   => true,
                        :length     => { :maximum => 50 }
  validates :first_name, :presence  => true,
                        :length     => { :maximum => 50 }
  validates :email, :presence       => true, 
                        :format     => { :with => email_regex }, 
                        :uniqueness => { :case_sensitive => false }
                        
  #validates nationality, :presence => true
  
end

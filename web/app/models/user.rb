# == Schema Information
# Schema version: 20080729231414
#
# Table name: users
#
#  id           :integer         not null, primary key
#  username     :string(255)
#  emailaddress :string(255)
#  password     :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class User < ActiveRecord::Base

  validates_presence_of :username
  validates_presence_of :emailaddress
  validates_presence_of :password
  validates_length_of :password, :is => 32
  
end

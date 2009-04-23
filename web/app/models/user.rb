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
  
  has_many :logs
  
end

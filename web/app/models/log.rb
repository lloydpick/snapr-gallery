# == Schema Information
# Schema version: 20080729231414
#
# Table name: logs
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  item       :string(255)
#  event      :string(255)
#  identifier :integer
#  created_at :datetime
#  updated_at :datetime
#

class Log < ActiveRecord::Base
  
  belongs_to :user
  
end

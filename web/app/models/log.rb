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

  def self.create_entry(user, item, event, identifier)
    log = Log.new
    log.user = user
    log.item = item
    log.event = event
    log.identifier = identifier
    log.save!
  end
  
end

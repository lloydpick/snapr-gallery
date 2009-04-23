# == Schema Information
# Schema version: 20090423150120
#
# Table name: albums
#
#  id          :integer         not null, primary key
#  parent_id   :integer         default(0)
#  title       :string(255)
#  description :string(255)
#  position    :integer
#  is_visible  :boolean         default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime
#  permalink   :string(200)
#

class Album < ActiveRecord::Base

  attr_accessor :current_user
  has_many :photos, :order => :position
  has_permalink :title
  acts_as_tree :order => "title" 
  acts_as_list

  default_scope :order => "title ASC"
  named_scope :root, :conditions => { :parent_id => 0 }
  named_scope :visible, :conditions => { :is_visible => true }

  after_create :create_create_audit
  after_update :create_edit_audit

  def create_create_audit
    create_audit("add_album")
  end

  def create_edit_audit
    create_audit("edit_album")
  end

  def create_audit(event)
    log = Log.new
    log.user = current_user
    log.item = "album"
    log.event = event
    log.identifier = self.id
    log.save!
  end

  def to_param
    permalink
  end
  
end

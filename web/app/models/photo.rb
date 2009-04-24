# == Schema Information
# Schema version: 20080729231414
#
# Table name: photos
#
#  id         :integer         not null, primary key
#  album_id   :integer
#  image_id   :integer
#  path       :string(255)
#  title      :string(255)
#  caption    :string(255)
#  is_visible :boolean         default(TRUE)
#  position   :integer
#  created_at :datetime
#  updated_at :datetime
#  permalink  :string(200)
#  geotag_id  :integer
#

class Photo < ActiveRecord::Base
  
  has_one :image, :conditions => 'parent_id is null'
  belongs_to :geotag
  belongs_to :album
  acts_as_list :scope => :album
  has_permalink :title

  after_create :create_audit
  after_update :edit_audit

  def create_audit
    Log.create_entry(User.find(1), "photo", "add_photo", self.id)
  end

  def edit_audit
    Log.create_entry(current_user, "photo", "edit_photo", self.id)
  end
  
  def to_param
    permalink
  end
  
end

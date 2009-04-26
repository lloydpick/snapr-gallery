require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  def setup
    @album = Album.new
    @album.title = "Album Title"
    @album.description = "Album Description"
    @album.parent_id = 0
    @album.is_visible = true
    @album.save!

    @photo = Photo.new
    @photo.album_id = @album.id
    @photo.image_id = 1
    @photo.title = "Photo Title"
    @photo.caption = "Photo Caption"
    @photo.is_visible = true
    @photo.position = 1
    #@photo.geotag_id = 1
  end

  def test_photo_should_always_belong_to_an_album
    @photo.album_id = nil
    assert !@photo.save, "Saved the photo without an album"
  end

  def test_photo_should_always_have_an_image
    @photo.image_id = nil
    assert !@photo.save, "Saved the photo without an image"
  end

  def test_photo_should_always_have_a_title
    @photo.title = nil
    assert !@photo.save, "Saved the photo with a title"
  end

  def test_photo_should_always_have_a_position
    @photo.position = nil
    assert !@photo.save, "Saved the photo with a position"
  end

  def test_permalink_should_be_generated_from_title
    @photo.save
    assert_equal("photo-title", @photo.permalink)
  end
  
end

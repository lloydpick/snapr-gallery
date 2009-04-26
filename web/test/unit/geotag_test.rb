require 'test_helper'

class GeotagTest < ActiveSupport::TestCase

  def setup
    @geotag = Geotag.new
    @geotag.latitude = 28.376133
    @geotag.longitude = -81.549396
    @geotag.zoom = 18
    @geotag.description = "Walt Disney World - Epcot - Entrance"
  end

  def test_should_not_save_geotag_without_latitude
    @geotag.latitude = nil
    assert !@geotag.save
  end

  def test_should_not_save_geotag_without_longitude
    @geotag.longitude = nil
    assert !@geotag.save
  end

  def test_should_not_save_geotag_without_zoom
    @geotag.zoom = nil
    assert !@geotag.save
  end

  def test_should_not_save_geotag_without_description
    @geotag.description = nil
    assert !@geotag.save
  end

  def test_latitude_should_only_be_a_float
    @geotag.latitude = "a"
    assert !@geotag.save
  end

  def test_longitude_should_only_be_a_float
    @geotag.longitude = "a"
    assert !@geotag.save
  end

  def test_zoom_should_only_be_an_integer
    @geotag.zoom = "a"
    assert !@geotag.save
  end

  def test_geotag_can_be_associated_with_a_photo
    @geotag.save!

    photo = Photo.new
    photo.album = Album.find(:first)
    photo.image_id = 1
    photo.geotag = @geotag
    photo.title = "Photo title"
    photo.position = 1
    photo.save
    photo.reload

    assert_equal @geotag, photo.geotag
  end
  
end
require 'test_helper'

class AlbumTest < ActiveSupport::TestCase

  def setup
    @album = Album.new
    @album.title = "Album Title"
    @album.description = "Album Description"
    @album.parent_id = 0
    @album.is_visible = true
  end

  def test_should_not_save_album_without_title
    @album.title = nil
    assert !@album.save, "Saved the album without a title"
  end

  def test_should_not_save_album_without_description
    @album.description = nil
    assert !@album.save, "Saved the album without a description"
  end

  def test_parent_id_should_never_be_nil
    @album.parent_id = nil
    assert !@album.save
  end

  def test_parent_id_should_only_be_integer
    @album.parent_id = "a"
    assert !@album.save
  end

  def test_permalink_should_be_inherited_from_parent_album
    @album.save!
    child = Album.new
    child.title = "Child Album"
    child.description = "Album Description"
    child.parent_id = @album.id
    child.save!
    assert_equal("album-title-child-album", child.permalink)
  end

  def test_permalink_should_be_generated_from_title
    @album.save
    assert_equal("album-title", @album.permalink)
  end

  def test_parent_id_should_link_to_the_parent_album
    @album.save!
    child = Album.new
    child.title = "Child Album"
    child.description = "Album Description"
    child.parent_id = @album.id
    child.save!
    assert_equal(@album, child.parent)
  end

  def test_named_scope_root_should_return_albums_with_parent_id_zero
    @album.save!
    # This is two as the fixtures have already created one also
    assert_equal(2, Album.root.size)
  end

  def test_named_scope_root_should_not_return_albums_with_a_valid_parent_id
    @album.parent_id = 1
    @album.save!
    assert_equal(1, Album.root.size)
  end

  def test_named_scope_visible_should_only_return_albums_which_are_not_visible
    @album.is_visible = false
    @album.save
    # This should be 1 as the fixtures have created a visible album already
    assert_equal(1, Album.visible.size)
  end
  
end

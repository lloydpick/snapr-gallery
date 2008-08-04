module AlbumsHelper

  def tree_ul(acts_as_tree_set, init=true, &block)
    if acts_as_tree_set.size > 0
      ret = '<ul>'
      acts_as_tree_set.collect do |item|
        next if item.parent_id && init
        ret += '<li>'
        ret += yield item
        ret += tree_ul(item.children, false, &block) if item.children.size > 0
        ret += '</li>'
      end
      ret += '</ul>'
    end
  end
  
  def count_photos(albums, init=true)
    
    ret = 0
    
    if albums.kind_of?(Album)
    
      ret = ret + Photo.find(:all, :conditions => { :album_id => albums.id }).size
      ret = ret + count_photos(albums.children, false) unless albums.children.empty?
    
    else
      
      for album in albums
        ret = ret + Photo.find(:all, :conditions => { :album_id => album.id }).size
        ret = ret + count_photos(album.children, false) unless album.children.empty?
      end
      
    end
    
    
    
    ret
    
  end

  
end

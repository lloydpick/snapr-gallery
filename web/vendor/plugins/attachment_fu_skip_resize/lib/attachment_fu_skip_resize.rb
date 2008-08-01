
module AttachmentFuSkipResize

   # protected
   def self.included(base)
     base.class_eval do
       alias_method_chain :resize_image_or_thumbnail!, :no_resize
     end
   end
   
   def resize_image_or_thumbnail_with_no_resize!(img)
     if (!respond_to?(:parent_id) || parent_id.nil?) && attachment_options[:resize_to] # parent image
       resize_image(img, attachment_options[:resize_to]) unless @skip_resize
     elsif thumbnail_resize_options # thumbnail
       resize_image(img, thumbnail_resize_options) 
     end
   end
      
end

module Technoweenie
   module AttachmentFu
      module InstanceMethods
         
         include AttachmentFuSkipResize

      end
   end
end

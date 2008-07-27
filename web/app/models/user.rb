class User < ActiveRecord::Base
  
  has_many :logs
  
end

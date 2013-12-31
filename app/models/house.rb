class House < ActiveRecord::Base
  attr_accessible :url, :city, :state, :zipcode, :house_type, :homeowner_id

 	belongs_to :homeowner 
 	has_many :pictures
 	
end

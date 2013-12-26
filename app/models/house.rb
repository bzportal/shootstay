class House < ActiveRecord::Base
  attr_accessible :url, :city, :state, :zipcode, :house_type, :photo

 	belongs_to :homeowner 
 	
  has_attached_file :photo, :styles => { :medium => "300x300>", mini: "120x120>", tiny: "50x50" }, 
    storage: :dropbox,
    dropbox_credentials: Rails.root.join("config/dropbox.yml"),
    default_url: "/assets/missing.jpg", 
    path: "upload/:class/:attachment/:style/:filename"
end

class Picture < ActiveRecord::Base
  attr_accessible :photo, :house_id

  belongs_to :house
  has_attached_file :photo
  # has_attached_file :photo, :styles => { :medium => "300x300>", mini: "120x120>", tiny: "50x50" }, 
  #   storage: :dropbox,
  #   dropbox_credentials: Rails.root.join("config/dropbox.yml"),
  #   default_url: "/assets/missing.jpg", 
  #   path: "upload/:class/:attachment/:style/:filename"

  include Rails.application.routes.url_helpers

  def to_jq_picture
    {
      "name" => read_attribute(:photo_file_name),
      "size" => read_attribute(:photo_file_size),
      "url" => photo.url(:original),
      "delete_url" => picture_path(self),
      "delete_type" => "DELETE" 
    }
  end
end
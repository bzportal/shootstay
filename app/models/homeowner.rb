class Homeowner < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email

  has_many :houses

  def name
  	self.last_name = " " if self.last_name.nil?
    self.first_name = " " if self.first_name.nil?
  	first_name + " " + last_name
  end
end

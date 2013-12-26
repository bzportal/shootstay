class Request < ActiveRecord::Base
  attr_accessible :preferred_location1, :preferred_location2, :location_type, :start_date, :end_date, :note, :status

  belongs_to :user

  LOCATION_TYPE = ['Beach', 'Downtown', 'Lake', 'Mountain', 'Near The Ocean', 'River', 'Waterfront', 'Golf', 'Skiing']
  STATUS = %w[created approved denied cancelled]
end

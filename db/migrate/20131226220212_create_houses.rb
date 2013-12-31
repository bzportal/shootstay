class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
    	t.references :homeowner
    	t.string :url
    	t.string :city
    	t.string :state
    	t.string :zipcode
    	t.string :house_type

      t.timestamps
    end
  end
end

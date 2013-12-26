class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
    	t.references :user
    	t.string :preferred_location1
    	t.string :preferred_location2
    	t.string :location_type
    	t.string :start_date
    	t.string :end_date
    	t.string :status
    	t.string :note, :limit => 4000

      t.timestamps
    end
  end
end

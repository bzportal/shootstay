class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
    	t.references :house
    	t.attachment :photo

      t.timestamps
    end
  end
end

class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :portfolio, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :biography, :string
    add_column :users, :status, :string
  end
end
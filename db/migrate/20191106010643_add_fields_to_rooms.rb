class AddFieldsToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :videoId, :string
    add_column :rooms, :seconds, :integer
    add_column :rooms, :state, :integer
    add_column :rooms, :users, :string
  end
end

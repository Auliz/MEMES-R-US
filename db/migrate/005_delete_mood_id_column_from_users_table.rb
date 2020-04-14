class DeleteMoodIdColumnFromUsersTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :mood_id, :integer
  end 
end 
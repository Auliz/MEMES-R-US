
class AddColumnsToFinalKeys < ActiveRecord::Migration[5.0]
  def change
    add_column :final_keys, :updated_mood_id, :integer
    add_column :final_keys, :updated_meme_id, :integer
  end 
end 
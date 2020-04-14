class CreateMoodsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :moods do |t|
      t.string :mood_name
    end 
  end
end

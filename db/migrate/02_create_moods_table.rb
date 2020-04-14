class CreateMoods < ActiveRecord::Migration[4.2]
  def change
    create_table :moods do |t|
      t.string :name
    end 
  end
end

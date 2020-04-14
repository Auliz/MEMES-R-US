class CreateFinalKeys < ActiveRecord::Migration[5.2]
    def change
        create_table :final_keys do |t|
            t.integer :mood_id
            t.integer :user_id
            t.integer :meme_id
        end
    end
end
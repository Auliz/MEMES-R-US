class CreateMemes < ActiveRecord::Migration[5.0]
    def change
        create_table :memes do |t|
            t.string :name
            t.string :url
        end
    end
end
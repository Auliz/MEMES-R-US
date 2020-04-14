class CreateMemes < ActiveRecord::Migration[4.2]
    def change
        create_table :memes do |t|
            t.string :name
            t.string :url
        end
    end
end
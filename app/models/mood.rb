class Mood < ActiveRecord::Base[5.0]
  belongs_to :meme
  belongs_to :user
  belongs_to :final_key
end 
class Mood < ActiveRecord::Base
  belongs_to :meme
  belongs_to :user
  belongs_to :final_key
end 


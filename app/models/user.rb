class User < ActiveRecord::Base[5.0]
  has_many :moods
  has_many :memes, through: :moods
  belongs_to :final_key
end 
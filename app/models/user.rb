class User < ActiveRecord::Base
  has_many :moods
  has_many :memes, through: :moods
  belongs_to :final_key
end 
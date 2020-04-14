class FinalKey < ActiveRecord::Base
    has_many :moods
    has_many :users
    has_many :memes
end
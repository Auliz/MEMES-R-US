require 'net/http'
require 'open-uri'
require 'json'
require 'pry'
require_relative 'app/models/meme'
 
class GetMemes
  page_number = rand(1..10)
  URL = "http://alpha-meme-maker.herokuapp.com/#{page_number}/"
 
  def get_memes
    uri = URI.parse(URL)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def program_memes
    meme_number = rand(1..23)
    programs = JSON.parse(self.get_memes)
    programs["data"][meme_number]["image"]
  end
end
# programs = GetMemes.new

# binding.pry
require 'net/http'
require 'open-uri'
require 'json'
require 'pry'
require 'launchy'
require_relative '../config/environment'

 
class GetMemes
  #page_number = rand(1..10)
  URL = "https://meme-api.herokuapp.com/gimme"
 
  def get_memes
    uri = URI.parse(URL)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def program_memes
    # meme_number = rand(1..34)
    programs = JSON.parse(self.get_memes)
    meme_name = programs["title"]
    meme_url = programs["url"]
    Meme.create(name: "#{meme_name}", url: "#{meme_url}")
    Launchy.open("#{meme_url}")
    nil
  end
  
end


require 'net/http'
require 'open-uri'
require 'json'
require 'pry'
require_relative '../config/environment'
 
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


    meme_name = programs["data"][meme_number]["name"]
    meme_url = programs["data"][meme_number]["image"]

    Meme.find_or_create_by(name: "#{meme_name}", url: "#{meme_url}").id

    return "Meme's name: #{meme_name}\nMeme's URL: #{meme_url}"
  end
end


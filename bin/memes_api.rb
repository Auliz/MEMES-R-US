require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

 
class GetMemes
 
  URL = "http://alpha-meme-maker.herokuapp.com/"
 
  def get_memes
    uri = URI.parse(URL)
    response = Net::HTTP.get_response(uri)
    response.body
  end


def program_memes
  # we use the JSON library to parse the API response into nicely formatted JSON
    programs = JSON.parse(self.get_memes)
    #programs.each do |program, memes, idk|
      programs["data"][0]["image"]
end
end

#programs = GetMemes.new.get_memes
#puts programs
#puts programs.program_memes.uniq
programs = GetMemes.new
puts programs.program_memes
require_relative '../config/environment'


puts "Please enter your current mood:"

user_mood_input = gets.strip.downcase

puts user_mood_input
 
p Mood.all
binding.pry


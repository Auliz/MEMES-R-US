require_relative '../config/environment'

puts "Please enter your first and last name:"
# takes in user input in the form of a string ex. "Stefani Waddell"
user_name_input = gets.chomp
# searches the users table for the name that was inputted, and if no such row exists, it creates one
user = User.find_or_create_by(name: "#{user_name_input}")


puts "How are you feeling today?\n"
puts "Mood list:"

# pulls all of the names from the moods table and puts them into an array
mood_list = Mood.pluck :name
# takes the above array (mood_list) and makes a nice numbered list as output
mood_list.each.with_index(1) do |value, index|
  puts "#{index}: #{value}"
end

puts "\nPlease enter a mood's number from the above list: "


# takes in user input in the form of a string ex. "3"
user_mood_input = gets.chomp
# subtracts 1 from the user input to match the index pattern of an array (arrays start at 0 and our list starts at 1)
mood_search = user_mood_input.to_i - 1
# uses the above index to search the array and get the name of the mood
mood_input_name = mood_list[mood_search]

# gets the primary key from the mood table for the mood that the user entered
user_mood_id_from_input = Mood.all.find_by(name: "#{mood_input_name}").id 

# gets the primary key of the current user
user_id_from_input = User.all.find_by(name: "#{user_name_input}").id

# creates (aka .new and .save) the join of the mood, user, and meme
FinalKey.create(mood_id: "#{user_mood_id_from_input}", user_id: "#{user_id_from_input}")




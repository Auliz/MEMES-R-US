require_relative '../config/environment'

puts "Please enter your first and last name:"
user_name_input = gets.chomp
user = User.find_or_create_by(name: "#{user_name_input}")


puts "How are you feeling today?\n"
puts "Mood list:"
mood_list = Mood.pluck :name
mood_list.each.with_index(1) do |value, index|
  puts "#{index}: #{value}"
end

puts "\nPlease enter a moods' number from the above list: "

# user input - 1 to search the array of moods 

# take mood name and search the databse for it's id
user_mood_id_from_input = Mood.all.find_by(name: "meh").id 

user_mood_input = gets.strip

user.mood_id = mood.id

# Final_key.create(mood: user_mood_input, name: user_name_input)
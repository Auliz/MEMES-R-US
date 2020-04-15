require_relative 'memes_api'

class Whatever

  @@programs = GetMemes.new

  def user_inputs_name
    puts "Please enter your first and last name:"
    user_name_input = gets.chomp # takes in user input in the form of a string ex. "Stefani Waddell"
    user = User.find_or_create_by(name: "#{user_name_input}") # searches the users table for the name that was inputted, and if no such row exists, it creates one
    FinalKey.create(user_id: "#{user.id}")
  end

  def user_inputs_mood
    puts "How are you feeling today?\n"
    puts "Mood list:"
    mood_list = Mood.pluck :name # pulls all of the names from the moods table and puts them into an array
    mood_list.each.with_index(1) do |value, index| # takes the above array (mood_list) and makes a nice numbered list as output
      puts "#{index}: #{value}"
    end
    puts "\nPlease enter a mood's number from the above list: "
    @@user_mood_input = gets.chomp # takes in user input in the form of a string ex. "3"
    mood_search = @@user_mood_input.to_i - 1 # subtracts 1 from the user input to match the index pattern of an array (arrays start at 0 and our list starts at 1)
    mood_input_name = mood_list[mood_search] # uses the above index to search the array and get the name of the mood
    user_mood_id_from_input = Mood.all.find_by(name: "#{mood_input_name}").id # gets the primary key from the mood table for the mood that the user entered
    FinalKey.update(mood_id: "#{user_mood_id_from_input}")
  end 

  def first_meme_return()
    if @@user_mood_input.to_i.between?(1,10) == true
      puts "\nSweet, here's a random meme"
      puts @@programs.program_memes
      # Save initial meme_id here
    else 
      puts "\nRuh roh"
    end 
  end


  def mood_change
    mood_list = Mood.pluck :name
    puts "\nDid your mood change? Enter 'yes' or 'no' below:"
    
    counter = 0
    no_counter = 0
    while (counter < 1 && no_counter < 5)
      user_yesno_input = gets.chomp
      if user_yesno_input == "yes" 
        counter = 1
        puts "\nNoice. What did it change to? Enter a number from the mood's list again:"
        mood_list.each.with_index(1) do |value, index|
          puts "#{index}: #{value}" 
        end
        user_changed_mood_input = gets.chomp
        # update mood_id here
      elsif no_counter < 4
        puts @@programs.program_memes
        puts "\nHow 'bout now? Yes or no:" 
        no_counter += 1
      else 
        puts "Out of memes for today. Seek therapy"
        no_counter += 1
      end
    end
  end
  
  def delete
    puts "Your mood has been updated. If you want to delete the updated mood and meme, enter 'd'. Otherwise, hit enter."
    user_input = gets.chomp
    if user_input == "d"
      FinalKey.all.last.destroy
      puts "cool deleted"
    else
      puts "To see your updated mood info, enter 'yes'. Otherwise, hit enter."
    end
  end

  def print_updated_info
    user_input = gets.chomp
    if user_input == "yes"
      puts "saved info will be right hurrr"
    else
      puts "bye felicia"
    end
  end
end
  








# subtracts 1 from the user input to match the index pattern of an array (arrays start at 0 and our list starts at 1)
#mood_search = @@user_mood_input.to_i - 1
# uses the above index to search the array and get the name of the mood
#mood_input_name = mood_list[mood_search]
# gets the primary key from the mood table for the mood that the user entered
#user_mood_id_from_input = Mood.all.find_by(name: "#{mood_input_name}").id 
# gets the primary key of the current user
#user_id_from_input = User.all.find_by(name: "#{user_name_input}").id
# creates (aka .new and .save) the join of the mood, user, and meme
#FinalKey.create(mood_id: "#{user_mood_id_from_input}", user_id: "#{user_id_from_input}")


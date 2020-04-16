require_relative 'memes_api'

require "tty-prompt"


class Whatever

  @@prompt = TTY::Prompt.new

  @@programs = GetMemes.new

  def user_inputs_name
    puts "Please enter your first and last name:"
    user_name_input = gets.chomp # takes in @@user input in the form of a string ex. "Stefani Waddell"
    @@user = User.find_or_create_by(name: "#{user_name_input}") # searches the users table for the name that was inputted, and if no such row exists, it creates one
    FinalKey.create(user_id: "#{@@user.id}")
  end

  def user_inputs_mood
    #puts "How are you feeling today?\n"
   # puts "Mood list:"
   mood_list = Mood.pluck :name 
   #@@user_mood_input = gets.chomp
   @@user_mood_input = @@prompt.select('How are you feeling today?') do |menu|
  
      menu.choice 'happy', 1
      menu.choice 'bored', 2
      menu.choice 'sad', 3
      menu.choice 'meh', 4
      menu.choice 'still a piece of garbage', 5
      menu.choice 'like a whole snack', 6
      menu.choice 'ugly', 7
      menu.choice 'vibes bro, just vibes', 8
      menu.choice 'chillin out maxin relaxin all cool', 9
      menu.choice 'depressy', 10
    end
    # pulls all of the names from the moods table and puts them into an array
    #@@prompt.select("How are you feeling today?", %w(happy bored sad meh))
   #mood_list.each.with_index(1) do |value, index| # takes the above array (mood_list) and makes a nice numbered list as output
      #puts "#{index}: #{value}"
  #end
    #puts "\nPlease enter a mood's number from the above list: "
    #@@user_mood_input = gets.chomp # takes in user input in the form of a string ex. "3"
    #mood_search = @@user_mood_input.to_i - 1 # subtracts 1 from the user input to match the index pattern of an array (arrays start at 0 and our list starts at 1)
    #mood_input_name = mood_list[mood_search] # uses the above index to search the array and get the name of the mood
    #user_mood_id_from_input = Mood.all.find_by(name: "#{mood_input_name}").id # gets the primary key from the mood table for the mood that the user entered
    #FinalKey.update(mood_id: "#{user_mood_id_from_input}")
  end 

  def first_meme_return
  #if @@user_mood_input.tobetween?(1,10) == true
    if @@user_mood_input.to_i.between?(1,10) == true
      puts "\nSweet, here's a random meme"
      puts @@programs.program_memes
      FinalKey.last.update(meme_id: "#{Meme.all.last.id}")
    else 
      puts "\nRuh roh"
    end 
  end


  def mood_change

    mood_list = Mood.pluck :name
    #puts "\nDid your mood change? Enter 'yes' or 'no' below:"
    user_yesno_input = @@prompt.ask('Did your mood change?')
    
    counter = 0
    no_counter = 0
    while (counter < 1 && no_counter < 5)
      #user_yesno_input = gets.chomp
      if user_yesno_input == "yes"
        counter = 1
        @@prompt.select('Noice. What did it change to?') do |menu|
  
        menu.choice 'happy', 1
        menu.choice 'bored', 2
        menu.choice 'sad', 3
        menu.choice 'meh', 4
        menu.choice 'still a piece of garbage', 5
        menu.choice 'like a whole snack', 6
        menu.choice 'ugly', 7
        menu.choice 'vibes bro, just vibes', 8
        menu.choice 'chillin out maxin relaxin all cool', 9
        menu.choice 'depressy', 10
        end
        #puts "\nNoice. What did it change to? Enter a number from the mood's list again:"
        #mood_list.each.with_index(1) do |value, index|
          #puts "#{index}: #{value}" 
        #user_changed_mood_input = gets.chomp
        # update mood_id here
      elsif no_counter < 4
        puts @@programs.program_memes
        user_yesno_input = @@prompt.ask('How bout now?')
        #puts "\nHow 'bout now? Yes or no:" 
        no_counter += 1
        FinalKey.last.update(meme_id: "#{Meme.all.last.id}")
      else 
        puts "Out of memes for today. Seek therapy"
        no_counter += 1
      end
    end
  end
  
  def print_updated_info
    user_input = @@prompt.ask('Your mood has been updated. Wanna see it?')
    #puts "Your mood's been updated. Wanna see? Enter 'yes' or 'no'"
    #user_input = gets.chomp
    if user_input == "yes"
      puts "saved info will be right hurrr"

      us_id = FinalKey.find_by(user_id: "#{@@user.id}").user_id
      mo_id = FinalKey.find_by(user_id: "#{@@user.id}").mood_id
      me_id = FinalKey.find_by(user_id: "#{@@user.id}").meme_id
      umo_id = FinalKey.find_by(user_id: "#{@@user.id}").updated_mood_id
      ume_id = FinalKey.find_by(user_id: "#{@@user.id}").updated_meme_id

      us_name = User.find_by(id: "#{us_id}").name
      mo_name = Mood.find_by(id: "#{mo_id}").name
      me_name = Meme.find_by(id: "#{me_id}").name
      me_url = Meme.find_by(id: "#{me_id}").url
      umo_name = Mood.find_by(id: "#{umo_id}").name
      binding.pry
      ume_name = Meme.find_by(id: "#{ume_id}").name
      ume_url = Meme.find_by(id: "#{ume_id}").url

      puts <<~ALL_INFO 
      Current User: #{us_name}
      Initial Mood: #{mo_name}
      Initial Meme: #{me_name}
      Initial Meme Link: #{me_url}
      Your mood was changed to: #{umo_name}
      The meme that changed your mood was: #{ume_name}
      The link to the meme that changed your mood was: #{ume_url}\n\n
      ALL_INFO
      
    elsif user_input == "no"
      #puts delete
      puts "ok deleted"
    else
      #puts print_updated_info
      puts "yes value didnt work"
    end
  end


  def delete
    user_input = @@prompt.select('To delete only your last memeage and moodage, choose delete last. To delete ALL of your memeage and moodage, choose delete all. To exit, press enter') do |menu|
  
      menu.choice 'd'
      menu.choice 'D'
    end
    #puts "If you wanna delete your moodage and memeage, enter 'd'. Otherwise, press enter to exit"
    #user_input = gets.chomp
    if user_input == "d"
      FinalKey.all.last.destroy
      puts "deleted last"
    elsif user_input == "D"
      puts "deleted all"
    else
      puts "fuck u. if this shows up its not workin bitch"
    end
  end
  
  def delete
    puts "To delete most recent memeage: enter 'd'. To delete all your memeage: enter 'D'. To escape the memeage: press 'enter'."
    user_input = gets.chomp
    if user_input == "d"
      FinalKey.all.where(user_id: "#{@@user.id}").last.destroy# destroy's last finalkey aka the current users
      puts "cool deleted last sesh"
    elsif user_input == "D"
      FinalKey.all.where(user_id: "#{@@user.id}").destroy_all
      puts "shaaaweeeet we deleted all your memeage"
    else 
      puts "bye felicia"
    end
  end


end
  

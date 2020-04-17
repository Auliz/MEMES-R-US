require_relative 'memes_api'
require 'pry'
require "tty-prompt"
require "colorize"

#require "artii"

#a = Artii::Base.new :font => 'slant'
#a.asciify('Mood Changer')



class Whatever


  @@prompt = TTY::Prompt.new(active_color: :magenta)


  @@prompt = TTY::Prompt.new

  @@programs = GetMemes.new

  def user_inputs_name
    puts "Please enter your first and last name:"
    user_name_input = gets.chomp
    # takes in @@user input in the form of a string ex. "Stefani Waddell"
    @@user = User.find_or_create_by(name: "#{user_name_input}") # searches the users table for the name that was inputted, and if no such row exists, it creates one
    FinalKey.create(user_id: "#{@@user.id}")
  end

  def user_inputs_mood
   mood_list = Mood.pluck :name 
   @@user_mood_input = @@prompt.select('How are you feeling today?') do |menu|
      menu.choice 'happy', 0
      menu.choice 'bored', 1
      menu.choice 'sad', 2
      menu.choice 'meh', 3
      menu.choice 'still a piece of garbage', 4
      menu.choice 'like a whole snack', 5
      menu.choice 'ugly', 6
      menu.choice 'vibes bro, just vibes', 7
      menu.choice 'chillin out maxin relaxin all cool', 8
      menu.choice 'depressy', 9
    end
    mood_input_name = mood_list[@@user_mood_input] # uses the above index to search the array and get the name of the mood
    user_mood_id_from_input = Mood.all.find_by(name: "#{mood_input_name}").id # gets the primary key from the mood table for the mood that the user entered
    FinalKey.last.update(mood_id: "#{user_mood_id_from_input}")
  end 

  def first_meme_return
    if @@user_mood_input.between?(0,9) == true
      puts "\nSweet, here's a random meme"
      @@programs.program_memes
      FinalKey.last.update(meme_id: "#{Meme.all.last.id}")
      @@i_meme = FinalKey.last.meme_id
    else 
      puts "\nRuh roh"
    end 
  end

  def mood_change
    user_yesno_input = @@prompt.ask('Did your mood change?')
    counter = 0
    no_counter = 0
    while (counter < 1 && no_counter < 25)
      if user_yesno_input == "yes"
        counter = 1
        updated_mood = @@prompt.select('Noice. What did it change to?') do |menu|
          menu.choice 'happy', 0
          menu.choice 'bored', 1
          menu.choice 'sad', 2
          menu.choice 'meh', 3
          menu.choice 'still a piece of garbage', 4
          menu.choice 'like a whole snack', 5
          menu.choice 'ugly', 6
          menu.choice 'vibes bro, just vibes', 7
          menu.choice 'chillin out maxin relaxin all cool', 8
          menu.choice 'depressy', 9
        end
        mood_list = Mood.pluck :name
        mood_input_name = mood_list[updated_mood]
        updated_mood_input = Mood.all.find_by(name: "#{mood_input_name}").id 
        FinalKey.last.update(updated_mood_id: "#{updated_mood_input}")
      elsif no_counter < 24
        @@programs.program_memes
        FinalKey.last.update(meme_id: "#{Meme.all.last.id}")
        @@u_meme = FinalKey.last.meme_id
        user_yesno_input = @@prompt.ask('How bout now?')
        no_counter += 1
      else 
        puts "Out of memes for today. Seek therapy"
        no_counter += 1
      end
    end
  end
  
  def print_updated_info
    user_input = @@prompt.ask('Your mood has been updated. Wanna see it? (yes/no)')
    if user_input == "yes"
      puts "\nsaved info will be right hurrr"
      us_id = FinalKey.find_by(user_id: "#{@@user.id}").user_id
      mo_id = FinalKey.find_by(user_id: "#{@@user.id}").mood_id
      umo_id = FinalKey.find_by(user_id: "#{@@user.id}").updated_mood_id
      puts <<~ALL_INFO 
      
      Current User: #{User.find_by(id: "#{us_id}").name}
      Initial Mood: #{Mood.find_by(id: "#{mo_id}").name}
      Initial Meme: #{Meme.find_by(id: "#{@@i_meme}").name}
      Initial Meme Link: #{Meme.find_by(id: "#{@@i_meme}").url}
      
      Your mood was changed to: #{Mood.find_by(id: "#{umo_id}").name}
      The meme that changed your mood was: #{Meme.find_by(id: "#{@@u_meme}").name}
      The link to the meme that changed your mood was: #{Meme.find_by(id: "#{@@u_meme}").url}\n\n
      ALL_INFO
    elsif user_input == "no"
      puts "ok deleted"
    else
      puts "yes value didnt work"
    end
  end

  def delete
    user_input = @@prompt.select('To delete only your last memeage and moodage, choose delete last. To delete ALL of your memeage and moodage, choose delete all. Otherwise, choose exit') do |menu|
      menu.choice 'delete last'
      menu.choice 'delete all'
      menu.choice 'exit'
    end
    if user_input == "delete last"
      FinalKey.all.where(user_id: "#{@@user.id}").last.destroy
      puts "deleted last"
    elsif user_input == "delete all"
      FinalKey.all.where(user_id: "#{@@user.id}").destroy_all
      puts "deleted all"
    else user_input == "exit"
      puts "bye felicia"
      `say "bye felicia"`
    end
  end
 
end
  

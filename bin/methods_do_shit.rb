require_relative 'memes_api'
require 'pry'
require "tty-prompt"
require "colorize"
require "artii"

class Whatever

  @@prompt = TTY::Prompt.new(active_color: :blue)

  def welcome
    puts <<-WIZRD
                                                  .
                                            *   .     .   .
                                              . (*.) .    * .
                                          .  ( .(.. ) )
                                         . .( (..*  ).*) .
                              .            ( *  . ). .)  .
                             /:\\           .  ( (. *.) .   
                            /:.:\\        .  .  )  *
                           /:.:.:\\        .*   /.  .    *  
            M A G I C     |wwWWWww|            /   .
                          (((""")))           /
         H A P P E N S !  (. @ @ .)          /
                          (( (_) ))      __ /
                         .-)))o(((-.    |:.\\
                        /.:((()))):.:\\  /.:.\\
                       /.:.:)))((:.:.:\\/.:.:.|
                      /.:.:.((()).:.:./.:.\\.:|
                     /.:.:.:.))((:.:.:.:.//  \\|
                    /.:.:.:Y:((().Y.:.:.//
                   /.:.:.:/:.:)).:\\:.:.| 
                  /.:.:.:/|.:.(.:.:\\:./ 
                 /.:.:.:/ |:.:.:.:.|\\'
                 `;.:./   |.:.:.:.:| `  
                   |./'   |:.:.:.:.|       
                   `'     |.:.:.:.:|   
                          |:.:.:.:.|    
                          |.:.:.:.:| 
                          |:.:.:.:.|
                         |:.:.:.:.:.|
                        |.:.:.:.:.:.:|  
                        |:.:.:.:.:.:.|
                        `-:.:.:.:.:.-'
WIZRD
    a = Artii::Base.new :font => 'gothic'
    puts "\e[34m" + "#{a.asciify('Mood Changer')}" + "\e[0m" 
    puts <<~DISCLAIMER
    -----DISCLAIMER-----
    The content you will see from this app is taken from Reddit, therefore we do not control what may appear. Some content you see may be NSFW.
    DISCLAIMER
    sleep 2
  end 

  def user_inputs_name
    puts "\n\nPlease enter your first and last name:"
    user_name_input = gets.chomp # takes in @@user input in the form of a string ex. "Stefani Waddell"
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
    mood_input_name = mood_list[@@user_mood_input] 
    user_mood_id_from_input = Mood.all.find_by(name: "#{mood_input_name}").id 
    FinalKey.last.update(mood_id: "#{user_mood_id_from_input}")
  end 

  def first_meme_return
    if @@user_mood_input != 4 
      puts "\nSweet, here's a random meme"
      programs = GetMemes.new
      programs.program_memes
      FinalKey.last.update(meme_id: "#{Meme.all.last.id}")
      @@i_meme = FinalKey.last.meme_id
    elsif @@user_mood_input == 4
      fork{ exec 'afplay', "/Users/auliz/Downloads/still-a-piece-of-garbage.mp3" }
      programs = GetMemes.new
      programs.program_memes
      FinalKey.last.update(meme_id: "#{Meme.all.last.id}")
      @@i_meme = FinalKey.last.meme_id
    else 
      puts "\nRuh roh"
    end 
  end

  def mood_change
    user_yesno_input = @@prompt.ask("Did your mood change? Enter 'yes' or 'no'")
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
        if updated_mood != 4 
          mood_list = Mood.pluck :name
          mood_input_name = mood_list[updated_mood]
          updated_mood_input = Mood.all.find_by(name: "#{mood_input_name}").id 
          FinalKey.last.update(updated_mood_id: "#{updated_mood_input}")
        elsif updated_mood == 4 
          fork{ exec 'afplay', "/Users/auliz/Downloads/still-a-piece-of-garbage.mp3" }
          mood_list = Mood.pluck :name
          mood_input_name = mood_list[updated_mood]
          updated_mood_input = Mood.all.find_by(name: "#{mood_input_name}").id 
          FinalKey.last.update(updated_mood_id: "#{updated_mood_input}")
        end 

      elsif no_counter < 24
        # FIX ME MAYBE?
        memes_do = GetMemes.new
        memes_do.program_memes
        FinalKey.last.update(meme_id: "#{Meme.all.last.id}")
        user_yesno_input = @@prompt.ask("How bout now? Enter 'yes' or 'no' ")
        no_counter += 1
      else 
        puts "Out of memes for today. Seek therapy"
        sleep 3
        no_counter += 1
      end
    end
    @@u_meme = FinalKey.last.meme_id
  end
  
  def print_updated_info
    sleep 3
    puts "\e[H\e[2J"
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
      # binding.pry
    elsif user_input == "no"
      puts "Okay whatever floats your boat"
      puts <<-HEREDOC
             __/___            
      _____/______|           
_______/_____\_______\_____     
\              < < <       |    
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
HEREDOC
    else
      puts "Ruh roh"
    end
  end

  def felicia
    sleep 1
    a = Artii::Base.new :font => 'gothic'
    puts "\e[34;5m" + "#{a.asciify('bye felicia')}" + "\e[0m" 
    `say "bye felicia"`
  end 


  def delete
    puts "\n\n"
    user_input = @@prompt.select('To delete only your last memeage and moodage, choose delete last. To delete ALL of your memeage and moodage, choose delete all. Otherwise, choose exit') do |menu|
      menu.choice 'delete last'
      menu.choice 'delete all'
      menu.choice 'exit'
    end
    if user_input == "delete last"
      FinalKey.all.where(user_id: "#{@@user.id}").last.destroy
      puts "deleted last"
      felicia
    elsif user_input == "delete all"
      FinalKey.all.where(user_id: "#{@@user.id}").destroy_all
      puts "deleted all"
      felicia
    else user_input == "exit"
      felicia
    end
  end
 
end
  

require_relative '../config/environment'
require_relative 'methods_do_shit'


class CallOnShit < Whatever
    methods = Whatever.new
    # menu_methods = CallOnShit.new

    methods.welcome
    methods.user_inputs_name
    methods.user_inputs_mood
    methods.first_meme_return
    methods.mood_change
    methods.print_updated_info
    methods.delete

  # self.menu

  # def self.menu 
  #   menu_input = @@prompt.select('What would you like to do?') do |menu|
  #     menu.choice 'Get mah mooood changed duhh', 1
  #     menu.choice 'Print my past memeage and moodage', 2
  #     menu.choice 'Delete sterf', 3
  #     menu.choice 'Say goodbye to the memes :(', 4
  #   end

  #   if menu_input == 1 
  #       methods.user_inputs_mood
  #       methods.first_meme_return
  #       methods.mood_change
  #       menu
  #   elsif menu_input == 2 
  #       methods.print_updated_info
  #       menu
  #   elsif menu_input == 3 
  #       methods.delete
  #       menu
  #   elsif menu_input == 4 
  #       methods.felicia
  #   end 
  # end 


end

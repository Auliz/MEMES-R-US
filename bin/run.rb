require_relative '../config/environment'
require_relative 'methods_do_shit'


class CallOnShit < Whatever
    methods = Whatever.new

    # puts "Welcome to Mood Changer, please select what you want to do:"
    # puts <<~ERMAGERHDMENU 
    # Option 1: Run the memeage
    # Option 2: Print your memeage
    # Option 3: Delete your memeage
    # ERMAGERHDMENU
    # menu_input = gets.chomp
    # if menu_input.to_i == 1
    #   methods.user_inputs_name
    #   methods.user_inputs_mood
    #   methods.first_meme_return
    #   methods.mood_change
    # elsif menu_input.to_i == 2 
    #   methods.print_updated_info
    # elsif menu_input.to_i == 3 
    #   methods.delete
    # end 
  
    methods.user_inputs_name
    methods.user_inputs_mood
    methods.first_meme_return
    methods.mood_change
    methods.print_updated_info
    methods.delete
end

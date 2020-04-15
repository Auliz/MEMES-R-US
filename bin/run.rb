require_relative '../config/environment'
require_relative 'methods_do_shit'

class CallOnShit < Whatever
methods = Whatever.new

def idk
    puts "Please enter your first and last name:"
    # takes in user input in the form of a string ex. "Stefani Waddell"
    user_name_input = gets.chomp
end
methods.user_inputs_name
methods.user_inputs_mood
methods.first_meme_return
methods.mood_change

methods.finder_methods
end

hi
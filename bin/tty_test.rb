require "tty-prompt"
require 'pry'

prompt = TTY::Prompt.new

shit = prompt.select("Choose your destiny?", %w(Scorpion Kano Jax))

binding.pry
require "tty-prompt"
require 'pry'

#prompt = TTY::Prompt.new

#hit = prompt.select("Choose your destiny?", %w(Scorpion Kano Jax))

#binding.pry

pid = fork{ exec 'afplay', "/Users/haley/Downloads/The Fresh Prince Of Bel Air Theme Song Full-[AudioTrimmer.com]-[AudioTrimmer.com].mp3" }
# environment

require 'date'
require 'time'
require 'colorize'
require 'colorized_string'
require 'dotenv'
require 'pry'
require 'launchy'
require 'open-uri'
require 'net/http'
require 'json'
require_relative "nyt_cli/version"
require_relative './nyt_cli/cli.rb'
require_relative './nyt_cli/book.rb'
require_relative './nyt_cli/api.rb'



# puts String.colors
# puts String.modes
# puts String.color_samples
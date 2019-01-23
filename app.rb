require 'bundler' # Brancher le Bundler au fichier app.rb > les require de gems deviennent inutiles mais le Gemfile doit être bien complété
Bundler.require # #require 'lib/app/scrapper.rb'

$:.unshift File.expand_path('./../lib', __FILE__)

require 'open-uri'
require 'app/scrapper'

scrap = Scrapper.new
scrap.save_as_csv

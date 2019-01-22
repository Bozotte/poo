require 'bundler' # Brancher le Bundler au fichier app.rb > les require de gems deviennent inutiles mais le Gemfile doit être bien complété
Bundler.require # #require 'lib/app/scrapper.rb'

$:.unshift File.expand_path("./../lib", __FILE__)
require 'lib/scrapper.rb'

#Scrapper.new.perform |è Pour faire appel à la classe Scrapper (récupération données)
#Scrapper.new.save_as_JSON
Scrapper.new.save_as_spreadsheet
#Scrapper.save_as_csv.perform

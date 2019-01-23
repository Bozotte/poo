
require 'bundler'
Bundler.require
# require 'nokogiri'
# require 'rubygems'
# require 'json'
# require "google_drive"
require 'pry'
# require 'open_uri'

class Scrapper

  attr_accessor :array_of_hash

def initialize

  @array_of_hash = []

  townhall=[]
  page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/val-d-oise.html"))
  page.xpath('//p/a').each do |name|
      townhall << name.text
  end

  email = []
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/"))
  news_links = page.css("a")
  news_links.each do |link|
      page_annuaire = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/#{link['href']}"))
      page_annuaire.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |mail|
          email << mail.text
      end
  end

  puts email
end

  hash = Hash[townhall.zip(email.map)]
  hash.each {|index| @array_of_hash << {index[0] => index[1]}}

end

def save_as_JSON # METHODE JSON #
     Dir.chdir ("db")
     json_file = File.open("db/mairie.json","w") do |f|
       f.write(@array_of_hash.to_json)
    end
end

def save_as_spreadsheet # METHODE SPREADSHEET #
      session = GoogleDrive::Session.from_config("config.json")
      new_sheet = session.spreadsheet_by_key("13Ey7nmVTcqG3egLjgV0oAvuXhsZIxK9tiz3KwuGamEo").worksheets[0]
      new_sheet[1,1] = "Ville"
      new_sheet[1, 2] = "E-mail"
      initialize.each_key.with_index {|k, i| new_sheet[i+2,1] = k}
      initialize.each_value.with_index {|v, i| new_sheet[i+2,2] = v}
      new_sheet.save()
      #binding.pry
      end

    def save_as_csv # METHODE CSV | Voir https://www.rubyguides.com/2018/10/parse-csv-ruby/
      Dir.chdir('db')
      CSV.open("email.csv", "wb") do |csv| # Pour écrire fichier csv = file.write ou file.open + le code
        @array_of_hash.each do |elements|
          csv << [elements.keys.at(0), elements.values.at(0)]
        end
      end
    end

    def self.perform # METHODE SELF #
  		puts "Welcome to Scrapper\n Tu veux le scrapping sous quel format ? JSON ? Spreadsheet ? CSV ?"
  		print "> "
  		choice = gets.to_i # entrée pour choisir le mode de scrapping des datas.
      		case choice
  		when 1
  			Scrapper.new.save_as_json
  			puts "JSON, bon choix"
        sleep(5) "Le fichier se trouve ici : .../db"
  		when 2
  			Scrapper.new.save_as_spreadsheet
  			puts "Ah, tu aimes Google ?, good for you"
        sleep (5)
        puts "Le fichier se trouve sur le Google drive à cette adresse  ..."
  		when 3
  			Scrapper.new.save_as_csv
  			puts "CSV, old school but cool !"
        sleep(5)
        puts "Le fichier se trouve ici .../db"
  		end
  	end

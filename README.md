# Organiser la structure d'un dossier Ruby (Programmation Orientée Objet)

L'objectif est d'avoir juste à faire $ bundle install et $ ruby app.rb quand on arrive dans le dossier, pour faire tourner l'application. Chaque fichier doit avoir une fonction unique et précise, représentée par une classe

Le fichier app.rb

1/ Pour de faire marcher le dossier, brancher le Bundler au fichier app.rb en ajoutant ces deux lignes : => Grâce à elles en en-tête du fichier à exécuter (ruby app.rb), les require de gems deviennent inutiles. Il suffit que ton Gemfile soit bien complété.
require 'bundler'
Bundler.require

2/ plus besoin de préciser le path exact
$:.unshift File.expand_path("./../lib", __FILE__)
require 'scrapper'

3/ Faire appel à la classe qui m'intéresse
MyClass.new.perform

# MAPS DU PROJET 

├── lib
│   ├── app
│   │   └── scrapper.rb
├── db
│   └── emails.csv
│   └── emails.json
├── spec
│   ├── spec_helper.rb
│   └── scrapper_spec.rb
├── app.md
├── README.md
├── Gemfile
├── Gemfile.lock
├── Autres fichiers (.env, .gitignore)
└── .rspec

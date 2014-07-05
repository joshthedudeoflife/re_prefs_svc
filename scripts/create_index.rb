require 'stretcher'
server = Stretcher::Server.new('http://localhost:9200')
server.index('keepbusy_user_preferences').create()
#create_index.rb
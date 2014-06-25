#!/bin/bash
if [ -z "$1" ]; then
  echo Your mySQL username is required as the first argument in the call
  echo usage: script/setup.sh root 
  exit
fi
bundle install
mkdir ./log
echo Enter your mysql password for user $1
mysql -u $1 -p < ./db/setup_db.sql
ruby -r "./lib/helpers/config_manager.rb" -e "ConfigManager.create_database_config('utf8','mysql2',
         're_prefs_svc', # db name
         're_prefs_u', #db username
         'ja89jh',  #db password
         { directories: {
           log: './log' # log file location (relative to base directory, or full path)
         }, 
         server: {
           port: 5701,  # port to run the server on
           request_timeout: {  # max time between timestamp and current time (in ms)
              __default: 30000,   # default for all requests
              admin: {
                status_get: 5000 # override server default for status get request
              }
           }           
         }  } )"
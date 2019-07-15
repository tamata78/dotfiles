#!/bin/bash

bundle install --path vendor/bundle
bundle exec rake db:migrate:reset
RAILS_ENV=test bundle exec rake db:migrate:reset 
bundle exec rake db:seed CATALOGS=all

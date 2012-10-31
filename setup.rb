#!/usr/bin/env ruby
puts "running `bundle install`"
system('bundle', 'install')
puts "running `db:migrate` task"
system(*'bundle exec rake db:migrate'.split)
puts "running `db:seed` task"
system(*'bundle exec rake db:seed'.split)
puts "Ready to roll out!"
puts "bundle exec rails s puma"
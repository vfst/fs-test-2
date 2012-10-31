# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

dates = %w[monday sunday tomorrow yesterday beginning_of_month end_of_month]
events = ['visit the gym', 'call mom', 'salary', 'linkin park concert', 'interview',
          'Skyfall', 'circus', 'visit doctor']

events.each { |event_title| Event.create(title: event_title, date: Date.today.send(dates.sample)) }

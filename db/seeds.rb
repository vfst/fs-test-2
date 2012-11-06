# encoding: UTF-8
user = User.create(name: 'Administrator', email: 'admin@example.com', password: 'password')

dates = %w[monday sunday tomorrow yesterday beginning_of_month end_of_month]
events = ['visit the gym', 'call mom', 'salary', 'linkin park concert', 'interview',
          'Skyfall', 'circus', 'visit doctor']

events.each { |event_title| user.events.create(title: event_title, date_str: Date.today.send(dates.sample).to_s) }

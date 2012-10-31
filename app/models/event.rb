class Event < ActiveRecord::Base
  attr_accessible :date, :recurring, :schedule_type, :title
  
  validates :date, :title, presence: true
end

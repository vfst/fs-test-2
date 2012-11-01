class Event < ActiveRecord::Base
  attr_accessible :date, :recurring, :schedule_type, :title
  default_value_for :date do
    Date.today
  end
  
  validates :date, :title, presence: true

  def self.at_range(start_date, end_date)
    where('date >= ? and date <= ?', start_date, end_date)
  end
end

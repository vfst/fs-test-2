# encoding: UTF-8
class Event < ActiveRecord::Base
  attr_accessible :date_str, :recurring, :schedule_type, :title
  default_value_for :date do
    Date.today
  end
  
  validates :date, :title, presence: true

  def self.at_range(start_date, end_date)
    where('date >= ? and date <= ?', start_date, end_date)
  end

  def date_str
    I18n.l(date)
  end

  def date_str=(date_string)
    self.date = Date.strptime(date_string, I18n.t('date.formats.default'))
  rescue ArgumentError, TypeError
    self.date = Date.today
  end
end

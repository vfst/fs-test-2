# encoding: UTF-8
class Schedule
  attr_reader :year, :month, :first_day_of_week,
              :start_date, :end_date, :day_names
  def initialize(year = nil, month = nil, first_day_of_week = 0)
    @year, @month, @first_day_of_week = year.to_i, month.to_i, first_day_of_week
    @year = Date.today.year if @year == 0
    @month = Date.today.month if @month == 0

    detect_date_range
    prepare_day_names
    group_events
  end

  def events
    @events ||= Event.at_range(@start_date, @end_date).all
  end

  def events_on(date)
    @groupped_events[date] || []
  end

  def range
    @range ||= (@start_date..@end_date)
  end

  def month_date
    @month_date ||= Date.new(@year.to_i, @month.to_i, 1)
  end

  private
  def detect_date_range
    days = %w(sunday monday tuesday wednesday thursday friday saturday).map(&:to_sym)

    # calculate start/end dates according to `first_day_of_week`
    @start_date = month_date.beginning_of_week(days[@first_day_of_week])
    @end_date = month_date.end_of_month.end_of_week(days[@first_day_of_week])
  end

  def prepare_day_names
    @day_names = I18n.t('date.abbr_day_names').dup
    @first_day_of_week.times { @day_names.push(day_names.shift) }
  end

  def group_events
    @groupped_events = events.group_by(&:date)
  end
end
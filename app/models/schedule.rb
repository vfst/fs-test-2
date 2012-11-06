# encoding: UTF-8
class Schedule
  attr_reader :year, :month, :options,
              :start_date, :end_date, :day_names
  def initialize(year = nil, month = nil, options = {})
    @year, @month = year.to_i, month.to_i
    @year = Date.today.year if @year == 0
    @month = Date.today.month if @month == 0
    @options = { first_day_of_week: 0 }.merge(options)

    detect_date_range
    prepare_day_names
    group_events
  end

  def events
    @events ||= Event.at_range(@start_date, @end_date).all
  end

  def events_on(date)
    @groupped_events[date]
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
    @start_date = month_date.beginning_of_week(days[options[:first_day_of_week]])
    @end_date = month_date.end_of_month.end_of_week(days[options[:first_day_of_week]])
  end

  def prepare_day_names
    @day_names = I18n.t('date.abbr_day_names').dup
    options[:first_day_of_week].times { @day_names.push(day_names.shift) }
  end

  def group_events
    # separate one-time events from recurring
    recurring = events.select(&:recurring?)
    @groupped_events = events.select(&:one_time?).group_by(&:date)

    range.each do |date|
      @groupped_events[date] ||= []
      recurring.each { |event| @groupped_events[date] << event if event.occurs_on?(date) }
    end
  end
end
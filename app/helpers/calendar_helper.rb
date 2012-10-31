# encoding: UTF-8

module CalendarHelper
  def calendar(opts = {})
    opts = { year: Date.today.year,
             month: Date.today.month,
             first_day_of_week: 0 }.merge(opts)
    days = %w(sunday monday tuesday wednesday thursday friday saturday).map(&:to_sym)

    # calculate start/end dates according to `opts[:first_day_of_week]`
    month = Date.new(opts[:year], opts[:month], 1)
    start_date = month.beginning_of_week(days[opts[:first_day_of_week]])
    end_date = month.end_of_month.end_of_week(days[opts[:first_day_of_week]])

    # get day names and reorder them according to `opts[:first_day_of_week]`
    day_names = I18n.t('date.abbr_day_names').dup
    opts[:first_day_of_week].times { day_names.push(day_names.shift) }

    render partial: 'calendar/view',
           locals: { range: (start_date..end_date),
                     month: month,
                     day_names: day_names,
                     calendar_opts: opts }
  end

  def calendar_date_classes(date, month_date)
    classes = %w(date)
    classes << 'current_month' if date.month == month_date.month
    classes << 'today' if date == Date.today

    classes
  end
end
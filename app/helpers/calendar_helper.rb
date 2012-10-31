# encoding: UTF-8

module CalendarHelper
  def calendar(opts = {})
    opts = { year: Date.today.year,
             month: Date.today.month,
             first_day_of_week: 0 }.merge(opts)

    schedule = Schedule.new(opts[:year], opts[:month], opts[:first_day_of_week])

    render partial: 'schedule/view', locals: { schedule: schedule }
  end

  def calendar_date_classes(date, month_date)
    classes = %w(date)
    classes << 'current_month' if date.month == month_date.month
    classes << 'today' if date == Date.today

    classes
  end
end
# encoding: UTF-8

module CalendarHelper
  def calendar_for(schedule)
    render partial: 'schedule/view', locals: { schedule: schedule }
  end

  def calendar_date_classes(date, month_date)
    classes = %w(date)
    classes << 'other_month' unless date.month == month_date.month
    classes << 'today' if date == Date.today

    classes
  end

  def calendar_pretty_day(date)
    if date.day == 1
      l(date, format: :not_so_short)
    else
      date.strftime('%e')
    end
  end
end
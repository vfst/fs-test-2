# encoding: UTF-8

module CalendarHelper
  def calendar_for(schedule)
    render partial: 'schedule/view', locals: { schedule: schedule }
  end

  def calendar_nav(schedule)
    links = []
    links << link_to('◀', events_path(year: schedule.month_date.prev_month.year,
                                      month: schedule.month_date.prev_month.month))

    links << link_to(t('calendar.today'), events_path)

    links << link_to('▶', events_path(year: schedule.month_date.next_month.year,
                                      month: schedule.month_date.next_month.month))

    links.join("\n").html_safe
  end

  def calendar_date_classes(date, month_date)
    classes = %w(date)
    classes << 'other_month' unless date.month == month_date.month
    classes << 'today' if date == Date.today

    classes
  end
end
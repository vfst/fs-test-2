require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  test "is instancable" do
    assert_nothing_raised { Schedule.new }
  end

  test "should use current month and year if params are empty" do
    schedule = Schedule.new
    assert_equal Date.today.year, schedule.year
    assert_equal Date.today.month, schedule.month
  end

  test "should correctly detect date range" do
    schedule = Schedule.new(2012, 1)
    assert_equal Date.new(2012, 1, 1), schedule.start_date
    assert_equal Date.new(2012, 2, 4), schedule.end_date
  end

  test "should respect first_day_of_week setting" do
    schedule = Schedule.new(2012, 1, 1)
    assert_equal Date.new(2011, 12, 26), schedule.start_date
    assert_equal Date.new(2012, 2, 5), schedule.end_date
  end

  test "should correctly order day names according to first_day_of_week setting" do
    schedule = Schedule.new(2012, 1, 0)
    assert_equal %w(Sun Mon Tue Wed Thu Fri Sat), schedule.day_names

    schedule = Schedule.new(2012, 1, 3)
    assert_equal %w(Wed Thu Fri Sat Sun Mon Tue), schedule.day_names
  end

  test "should collect all events in date range" do
    schedule = Schedule.new(2012, 11)
    assert_equal 4, schedule.events.size
  end

  test "should group events by date" do
    schedule = Schedule.new(2012, 11)
    assert_equal 3, schedule.events_on(Date.new(2012, 10, 31)).size
    assert_equal 1, schedule.events_on(Date.new(2012, 11, 10)).size
  end

  test "should return empty array if no events are found" do
    schedule = Schedule.new(2012, 11)
    assert_equal [], schedule.events_on(Date.new(2012, 11, 20))
  end
end
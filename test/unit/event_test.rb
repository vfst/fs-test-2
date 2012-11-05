require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "should parse date string" do
    e = Event.new(date_str: '2010-02-11')
    assert_equal Date.new(2010, 02, 11), e.date
  end

  test "should use Date.today if date_string is invalid" do
    e = Event.new(date_str: 'some ugly text')
    assert_equal Date.today, e.date
  end

  test "should return correct value from occurs_on? for one-time event" do
    e = Event.new(date_str: '2020-02-02')

    assert !e.recurring?
    assert e.occurs_on?(Date.new(2020, 2, 2))
    assert !e.occurs_on?(Date.new(2010, 1, 1))
  end

  test "should return false from occurs_on? for recurring events in the future" do
    e = events(:daily)

    assert e.daily?
    assert !e.occurs_on?(e.date.advance(years: -1))
  end

  test "should return correct value from occurs_on? for daily events" do
    e = events(:daily)

    assert e.daily?
    assert e.occurs_on?(Date.new(2020, 3, 3))
  end

  test "should return correct value from occurs_on? for weekly events" do
    e = events(:weekly)

    assert e.weekly?
    assert e.occurs_on?(e.date.advance(weeks: 2))
    assert !e.occurs_on?(e.date.advance(days: 1))
  end

  test "should return correct value from occurs_on? for monthly events" do
    e = events(:monthly)

    assert e.monthly?
    assert e.occurs_on?(e.date.advance(months: 3))
    assert !e.occurs_on?(e.date.advance(months: 1, days: 3))
  end

  test "should return correct value from occurs_on? for yearly events" do
    e = events(:yearly)

    assert e.yearly?
    assert e.occurs_on?(e.date.advance(years: 5))
    assert !e.occurs_on?(e.date.advance(months: 1))
  end

  test "should not include .cloned class if date was not specified" do
    e = events(:daily)

    assert !e.classes.include?('cloned')
  end

  test "should not include .cloned class if date is event.date" do
    e = events(:daily)

    assert !e.classes(e.date).include?('cloned')
  end

  test "should include .cloned class if necessary" do
    e = events(:daily)

    assert e.classes(e.date.advance(months: 1)).include?('cloned')
  end
end

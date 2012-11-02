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

  test "should return correct value from occur_at? for one-time event" do
    e = Event.new(date_str: '2020-02-02')

    assert !e.recurring?
    assert e.occur_at?(Date.new(2020, 2, 2))
    assert !e.occur_at?(Date.new(2010, 1, 1))
  end

  test "should return false from occur_at? for recurring events in the future" do
    e = build_recurring_event(schedule_type: Event::DAILY)

    assert e.daily?
    assert !e.occur_at?(Date.new(2010, 1, 1))
  end

  test "should return correct value from occur_at? for daily events" do
    e = build_recurring_event(schedule_type: Event::DAILY)

    assert e.daily?
    assert e.occur_at?(Date.new(2020, 3, 3))
  end

  test "should return correct value from occur_at? for weekly events" do
    e = build_recurring_event(schedule_type: Event::WEEKLY)

    assert e.weekly?
    assert e.occur_at?(Date.new(2020, 2, 16))
    assert !e.occur_at?(Date.new(2020, 2, 19))
  end

  test "should return correct value from occur_at? for monthly events" do
    e = build_recurring_event(schedule_type: Event::MONTHLY)

    assert e.monthly?
    assert e.occur_at?(Date.new(2020, 3, 2))
    assert !e.occur_at?(Date.new(2020, 2, 16))
  end

  test "should return correct value from occur_at? for yearly events" do
    e = build_recurring_event(schedule_type: Event::YEARLY)

    assert e.yearly?
    assert e.occur_at?(Date.new(2021, 2, 2))
    assert !e.occur_at?(Date.new(2020, 3, 2))
  end

  private
  def build_recurring_event(params = {})
    Event.new({ date_str: '2020-02-02', recurring: true }.merge(params))
  end
end

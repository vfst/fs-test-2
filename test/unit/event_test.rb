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
end

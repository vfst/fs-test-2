require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schedule)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { date_str: @event.date_str, recurring: @event.recurring, schedule_type: @event.schedule_type, title: @event.title }
    end

    assert_redirected_to events_url(date_params(@event))
  end

  test "should create event via xhr" do
    assert_difference('Event.count') do
      post :create, event: { date_str: @event.date_str, title: @event.title }, format: :js
    end

    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    put :update, id: @event, event: { date_str: @event.date_str, recurring: @event.recurring, schedule_type: @event.schedule_type, title: @event.title }
    assert_redirected_to events_url(date_params(@event))
  end

  test "should update event via xhr" do
    put :update, id: @event, event: { title: 'new title' }, format: :js
    assert_response :success
  end

  test "should move event to another date" do
    put :move, id: @event, event: { date_str: '2020-01-01' }, format: :js
    assert_equal @event.reload.date, Date.new(2020, 1, 1)
    assert_response :success
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_url(date_params(@event))
  end

  test "should destroy event via xhr" do
    assert_difference("Event.count", -1) do
      delete :destroy, id: @event, format: :js
    end

    assert_response :success
  end

  private
  def date_params(event)
    { year: event.date.year, month: event.date.month }
  end
end

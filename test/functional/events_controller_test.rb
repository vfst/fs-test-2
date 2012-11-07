require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @event = events(:one)
    sign_in users(:user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schedule)
  end

  test "should get common" do
    get :common
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

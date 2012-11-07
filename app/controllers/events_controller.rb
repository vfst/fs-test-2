# encoding: UTF-8
# TODO: выпадайка с месяцем-годом не влезает с русской локалью
# TODO: ссылка на календарь со всеми событиями
# TODO: favicon
# TODO: print.css
# TODO: перевод флешей
# TODO: ie
# TODO: deploy на heroku
# TODO: почта, восстановление пароля
class EventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @schedule = Schedule.new(params[:year], params[:month],
                             first_day_of_week: t('date.first_day_of_week'),
                             user: current_user)
  end

  def common
    @schedule = Schedule.new(params[:year], params[:month],
                             first_day_of_week: t('date.first_day_of_week'))
  end

  def new
    @event = current_user.events.new(date_str: params[:date_str])
    render :new, layout: !request.xhr?
  end

  def edit
    @event = current_user.events.find(params[:id])
    render :edit, layout: !request.xhr?
  end

  def create
    @event = current_user.events.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_url(date_params(@event)), notice: 'Event was successfully created.' }
        format.js { render json: @event, content_type: :json }
      else
        format.html { render action: 'new' }
        format.js { head :unprocessable_entity }
      end
    end
  end

  def update
    @event = current_user.events.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to events_url(date_params(@event)), notice: 'Event was successfully updated.' }
        format.js { render json: @event, content_type: :json }
      else
        format.html { render action: 'edit' }
        format.js { head :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url(date_params(@event)) }
      format.js
    end
  end

  private
  def date_params(event)
    { year: event.date.year, month: event.date.month}
  end
end

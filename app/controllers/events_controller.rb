# TODO: работа с повторяющимися событиями
# TODO: перетаскивание событий по датам
# TODO: выпадайка с месяцем/годом при щелчке на текущий месяц
class EventsController < ApplicationController
  def index
    @schedule = Schedule.new(params[:year], params[:month])
  end

  def new
    @event = Event.new(date_str: params[:date_str])
    render :new, layout: !request.xhr?
  end

  def edit
    @event = Event.find(params[:id])
    render :edit, layout: !request.xhr?
  end

  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_url(date_params(@event)), notice: 'Event was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js { render nothing: true, status: :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to events_url(date_params(@event)), notice: 'Event was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js { render nothing: true, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])
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

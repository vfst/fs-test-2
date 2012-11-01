# TODO: работа с повторяющимися событиями
# TODO: перетаскивание событий по датам
# TODO: выпадайка с месяцем/годом при щелчке на текущий месяц
# TODO: показывать, что событие добавлено или изменилось
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

    if @event.save
      redirect_to events_url, notice: 'Event was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to events_url, notice: 'Event was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_url
  end
end

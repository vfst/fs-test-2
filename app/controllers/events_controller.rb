# TODO: работа с повторяющимися событиями
# TODO: добавление событий в модальном окне
# TODO: редактирование событий в модальном окне
# TODO: перетаскивание событий по датам
# TODO: выпадайка с месяцем/годом при щелчке на текущий месяц
class EventsController < ApplicationController
  def index
    @schedule = Schedule.new(params[:year], params[:month])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
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

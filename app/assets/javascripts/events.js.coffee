jQuery ->
  $emodal = $('#event_modal')

  eventOccursOn = (event, date) ->
    eventDate = new Date(event.date)

    if event.recurring
      return false if date < eventDate

      switch event.schedule_type
        when 'daily' then true
        when 'weekly' then eventDate.getDay() is date.getDay()
        when 'monthly' then eventDate.getDate() is date.getDate()
        when 'yearly' then (eventDate.getDate() is date.getDate) and (eventDate.getMonth() is date.getMonth())
        else false
    else
      eventDate.getTime() is date.getTime()

  eventToHTML = (data, date) ->
    extras = ''
    if date? and data.recurring and (date.getTime() isnt (new Date(data.date)).getTime())
      extras = 'cloned'

    "<li data-id=\"#{data.id}\" class=\"#{data.classes.join(' ')} #{extras}\">
      <span>#{data.title}</span>
     </li>"

  updateEvent = (data) ->
    $(".event_#{data.id}").remove()

    for date in $('.calendar__grid .date')
      _date = date.dataset.date
      if eventOccursOn(data, new Date(_date))
        $elem = $(eventToHTML(data, new Date(_date)))
        $elem.appendTo(".calendar__grid .date[data-date=#{_date}] .events").effect('highlight')
        $elem.draggable(revert: 'invalid') unless $elem.is('.cloned')


  $('.modal-body').on('ajax:success', 'form', (e, data) ->
    updateEvent(data)
    $emodal.hide()
  )

  $('.calendar__grid .date .events li:not(.cloned)').draggable(revert: 'invalid')
  $('.calendar__grid .date').droppable(
    accept: '.event',
    drop: (e, ui) ->
      event_id = ui.draggable.attr('data-id')
      $.post("/events/#{event_id}.js",
             { _method: 'put', event: { date_str: $(@).attr('data-date') } },
             (data) -> updateEvent(data))
  )
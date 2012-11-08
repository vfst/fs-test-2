jQuery ->
  $emodal = $('#event_modal')

  parseISO8601 = (dateStringInRange) ->
    isoExp = /^\s*(\d{4})-(\d\d)-(\d\d)\s*$/
    date = new Date(NaN)
    month = 0
    parts = isoExp.exec(dateStringInRange);

    if parts?
      month = +parts[2]
      date.setFullYear(parts[1], month - 1, parts[3])
      if(month isnt date.getMonth() + 1)
        date.setTime(NaN)

    date

  eventOccursOn = (event, date) ->
    eventDate = parseISO8601(event.date)

    if event.recurring
      return false if date < eventDate

      switch event.schedule_type
        when 'daily' then true
        when 'weekly' then eventDate.getDay() is date.getDay()
        when 'monthly' then eventDate.getDate() is date.getDate()
        when 'yearly' then (eventDate.getDate() is date.getDate()) and (eventDate.getMonth() is date.getMonth())
        else false
    else
      eventDate.getTime() is date.getTime()

  eventToHTML = (data, date) ->
    extras = ''
    if date? and data.recurring and (date.getTime() isnt parseISO8601(data.date).getTime())
      extras = 'cloned'

    "<li data-id=\"#{data.id}\" class=\"#{data.classes.join(' ')} #{extras}\">
      <a href=\"/events/#{data.id}/edit\">#{data.title}</a>
     </li>"

  updateEvent = (data) ->
    $(".event_#{data.id}").remove()

    for date in $('.calendar__grid .date')
      _date = $(date).attr('data-date')
      if eventOccursOn(data, parseISO8601(_date))
        $elem = $(eventToHTML(data, parseISO8601(_date)))
        $elem.appendTo(".calendar__grid .date[data-date=#{_date}] .events").effect('highlight')
        $elem.draggable(revert: 'invalid') unless $elem.is('.cloned')


  $emodal.on('ajax:success', 'form', (e, data) ->
    updateEvent(data)
    $emodal.hide()
  )

  $emodal.on('ajax:error', 'form', -> $emodal.effect('shake'))

  $('.calendar__grid .date .events li:not(.cloned)').draggable(revert: 'invalid')
  $('.calendar__grid .date').droppable(
    accept: '.event',
    drop: (e, ui) ->
      event_id = ui.draggable.attr('data-id')
      $.post("/events/#{event_id}.js",
             { _method: 'put', event: { date_str: $(@).attr('data-ldate') } },
             (data) -> updateEvent(data))
  )
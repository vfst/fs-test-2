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

  eventToHTML = (data) ->
    "<li data-id=\"#{data.id}\" class=\"#{data.classes}\">#{data.title}</li>"

  updateEvent = (data) ->
    $(".event_#{data.id}").remove()
    eventHTML = eventToHTML(data)

    for date in $('.calendar__grid .date')
      _date = date.dataset.date
      if eventOccursOn(data, new Date(_date))
        $(eventHTML).appendTo(".calendar__grid .date[data-date=#{_date}] .events")
                    .effect('highlight').draggable()


  $('.schedule_types_toggle').live('click', (e) ->
    $checkbox = $(@).find('input:checkbox')
    $schedule_types = $('.schedule_types')

    if $checkbox.is(':checked')
      $schedule_types.show()
      $checkbox.attr('checked', true)
      $schedule_types.find('input:first').attr('checked', true)
    else
      $schedule_types.hide()
      $schedule_types.find('input:radio').attr('checked', false)
      $checkbox.attr('checked', false)
  )

  $('.calendar__grid .date').click(->
    $emodal.removeData('modal')
    $emodal.find('.modal-body').load("/events/new?date_str=#{@.dataset.date}", ->
      $emodal.modal('show')
      $(@).find('#event_title').focus()
    )
    false
  )

  $('.calendar__grid .date .events').on('click', 'li', ->
    $emodal.removeData('modal')
    $emodal.find('.modal-body').load("/events/#{@.dataset.id}/edit", ->
      $emodal.modal('show')
      $(@).find('#event_title').focus()
    )
    false
  )

  $('.modal-body').on('ajax:success', 'form', (e, data) ->
    updateEvent(data)
    $emodal.hide()
  )

  $('.calendar__grid .date .events li').draggable(revert: 'invalid')
  $('.calendar__grid .date').droppable(
    accept: '.event',
    drop: (e, ui) ->
      that = @
      event_id = ui.draggable.attr('data-id')
      $.post("/events/#{event_id}.js",
             { _method: 'put', event: { date_str: $(@).attr('data-date') } },
             (data) -> updateEvent(data))
  )
jQuery ->
  $emodal = $('#event_modal')

  # new event
  $('.calendar__grid .date, .calendar__new_event a').click(->
    $emodal.removeData('modal')
    $emodal.find('.modal-body').load("/events/new?date_str=#{$(@).attr('data-ldate')}", ->
      $emodal.modal('show')
      $(@).find('#event_title').focus()
    )
    false
  )

  # edit event
  $('.calendar__grid .date .events').on('click', 'li', ->
    $emodal.removeData('modal')
    $emodal.find('.modal-body').load("/events/#{$(@).attr('data-id')}/edit", ->
      $emodal.modal('show')
      $(@).find('#event_title').focus()
    )
    false
  )
jQuery ->
  $emodal = $('#event_modal')

  # new event
  $('.calendar__grid .date, .calendar__new_event a').click(->
    $emodal.removeData('modal')
    $emodal.find('.modal-body').load("/events/new?date_str=#{@.dataset.ldate}", ->
      $emodal.modal('show')
      $(@).find('#event_title').focus()
    )
    false
  )

  # edit event
  $('.calendar__grid .date .events').on('click', 'li', ->
    $emodal.removeData('modal')
    $emodal.find('.modal-body').load("/events/#{@.dataset.id}/edit", ->
      $emodal.modal('show')
      $(@).find('#event_title').focus()
    )
    false
  )
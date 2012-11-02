jQuery ->
  $emodal = $('#event_modal')

  $('.calendar__grid .date').click((e) ->
    e.preventDefault()
    $emodal.removeData('modal')
    $emodal.find('.modal-body').load("/events/new?date_str=#{@.dataset.date}", ->
      $emodal.modal('show')
      $(@).find('#event_title').focus()
    )
    false
  )

  $('.calendar__grid .date .events').on('click', 'li', (e) ->
    e.preventDefault()
    $emodal.removeData('modal')
    $emodal.find('.modal-body').load("/events/#{@.dataset.id}/edit", ->
      $emodal.modal('show')
      $(@).find('#event_title').focus()
    )
    false
  )
jQuery ->
  $emodal = $('#event_modal')

  # recurring options
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

  # new event
  $('.calendar__grid .date, .calendar__new_event a').click(->
    $emodal.removeData('modal')
    $emodal.find('.modal-body').load("/events/new?date_str=#{@.dataset.date}", ->
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
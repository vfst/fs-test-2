jQuery ->
  $('.calendar__grid .date').click(->
    $('#event_modal').removeData('modal')
    $('#event_modal').modal(remote: "/events/new?date_str=#{@.dataset.date}")
    false
  )

  $('.calendar__grid .date .events').on('click', 'li', ->
    $('#event_modal').removeData('modal')
    $('#event_modal').modal(remote: "/events/#{@.dataset.id}/edit")
    false
  )
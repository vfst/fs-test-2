jQuery ->
  $emodal = $('#event_modal')
  $('[data-toggle]').live('click', ->
    $($(@).attr('data-toggle')).toggle()
    false
  )

  $('.schedule_types_toggle').live('click', (e) ->
    $checkbox = $(@).find('input:checkbox')
    $schedule_types = $('.schedule_types')

    if $checkbox.is(':checked')
      $('.schedule_types').show()
      $checkbox.attr('checked', true)
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

  $('.calendar__grid .date .events li').draggable(revert: 'invalid')
  $('.calendar__grid .date').droppable(
    accept: '.event',
    drop: (e, ui) ->
      that = @
      event_id = ui.draggable.attr('data-id')
      console.log(ui.draggable)
      $.post("/events/#{event_id}/move", { _method: 'put', event: { date_str: $(@).attr('data-date') } }, ->
        $(that).find('.events').append(ui.draggable.attr('style', 'position: relative'))
      )
  )
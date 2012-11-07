jQuery ->
  $('[data-toggle]').live('click', ->
    $($(@).attr('data-toggle')).toggle()
    false
  )

  $('.flash').prepend('<i class="close">×</i>')
  $('.flash').on('click', '.close', -> $(this).parent().hide('slow').remove())

  # event recurring options
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

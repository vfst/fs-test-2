jQuery ->
  $('[data-toggle]').live('click', ->
    $($(@).attr('data-toggle')).toggle()
    false
  )

  $('.flash').prepend('<i class="close">×</i>')
  $('.flash').on('click', '.close', -> $(this).parent().hide('slow').remove())

$('[data-toggle]').live('click', ->
  $($(@).attr('data-toggle')).toggle()
  false
)
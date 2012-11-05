$('#event_modal').hide()
$('.event_<%= @event.id %>').hide('slow', -> $(@).remove())

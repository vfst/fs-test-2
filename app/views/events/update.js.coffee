event_html = "<%= escape_javascript(render(partial: 'schedule/event', locals: { event: @event })) %>"
$('#event_<%= @event.id %>').remove()
$(event_html).appendTo('.calendar__grid .date[data-date=<%= l(@event.date) %>] .events')
             .effect('highlight')

$('#event_modal').hide()
module EventsHelper
  def event_actions_cancel_link
    link_opts = { class: :alternate }
    link_opts[:data] = { dismiss: :modal } if request.xhr?

    link_to(t('event.actions.cancel'), events_path, link_opts)
  end
end

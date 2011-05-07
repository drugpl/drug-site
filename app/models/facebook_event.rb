class FacebookEvent
  def initialize(event_id)
    @event_id = event_id
  end

  def attendants(options = {})
    FbGraph::Query.new("
      SELECT uid, name, pic_square, profile_url
      FROM user
      WHERE uid IN (
        SELECT uid FROM event_member WHERE eid='#{@event_id}' AND rsvp_status='attending'
      )
    ").fetch(options[:access_token] || app.get_access_token)
  end

  private

  def app
    @app ||= FbGraph::Application.new(AppConfig[:facebook_app_id], :secret => AppConfig[:facebook_app_secret])
  end
end

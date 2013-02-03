module ApplicationHelper
  def calendar_link(event)
    link_to image_tag('glyphicons_045_calendar.png'), events_path, format: :ics
  end

  def map_link(venue)
    link_to image_tag('glyphicons_242_google_maps.png'), "https://maps.google.com/?ll=#{venue.latitude},#{venue.longitude}"
  end

  def map_section(venue, depth=14)
    "<section class='map' data-lat='#{venue.latitude}' data-lng='#{venue.longitude}' data-depth='#{depth}'></section>"
  end

  def avatar_link(person, size = 64)
    link_to image_tag(avatar_url(person, size)), person
  end

  def speaker_link(speaker)
    link_to speaker.full_name, speaker
  end

  def time_tag(time, format = :default)
    content_tag(:time, datetime: time.iso8601) do
      l(time, format: format)
    end
  end

  def twitter_link(handle, label = nil)
    label ||= handle
    link_to label, "https://twitter.com/#{handle}"
  end
end

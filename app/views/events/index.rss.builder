xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title I18n.t("events.rss.title")
    xml.description I18n.t("events.rss.description")
    xml.link events_url(:rss)

    for event in @feed_events
      xml.item do
        xml.title event.title
        xml.description event.description
        xml.pubDate event.updated_at.to_s(:rfc822)
        xml.link event_url(event)
        xml.guid event_url(event)
      end
    end
  end
end

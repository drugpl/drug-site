xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title I18n.t("events.rss.title")
    xml.description I18n.t("events.rss.description")
    xml.link events_url(:rss)
    
    for event in @events
      xml.item do
        xml.title event.title
        xml.description event.textilized_description
        xml.pubDate event.created_at.to_s(:rfc822)
        xml.link event_url(event)
        xml.guid event_url(event)
      end
    end
  end
end

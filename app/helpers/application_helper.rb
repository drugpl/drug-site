require 'settings'

module ApplicationHelper
  def site_menu
    [
      [I18n.t("site_menu.pages.home"), root_path],
      [I18n.t("site_menu.pages.events"), events_path],
      [I18n.t("site_menu.pages.contact"), "mailto:all[KILLSPAMMERS]drug.org.pl"]
    ]
  end

  def load_maps
    uri = "http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=#{Settings.google_maps[:api_key]}"
    javascript_include_tag uri.html_safe
  end
end

module ApplicationHelper
  PAGES = %w(home events contact)

  def site_menu
    PAGES.collect { |page| [I18n.t("site_menu.pages.#{page}"), page == 'home' ? root_path : send("#{page}_path")] }
  end

  # def load_maps
  #   uri = "http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=#{Settings.google_maps[:api_key]}"
  #   javascript_include_tag uri.html_safe
  # end
end

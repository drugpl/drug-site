module ApplicationHelper
  PAGES = %w(home)

  def site_menu
    PAGES.collect { |page| [I18n.t("site_menu.pages.#{page}"), page == 'home' ? root_path : send("#{page}_path")] }
  end
end

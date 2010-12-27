# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Drug::Application.initialize!

WillPaginate::ViewHelpers.pagination_options[:previous_label] = I18n.t(:previous_page)
WillPaginate::ViewHelpers.pagination_options[:next_label] = I18n.t(:next_page)

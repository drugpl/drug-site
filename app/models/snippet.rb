require 'textilized_attributes'

class Snippet < ActiveRecord::Base
  include TextilizedAttributes

  LABEL_FORMAT = /^[a-zA-Z\d_]+$/

  validates :label,
    presence: true,
    format: { with: LABEL_FORMAT },
    uniqueness: true

  def self.[](label)
    find_or_create_by_label(label)
  end

  textilized_attrs :content
end

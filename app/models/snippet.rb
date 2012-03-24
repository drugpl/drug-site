class Snippet < ActiveRecord::Base
  LABEL_FORMAT = /^[a-zA-Z\d_]+$/

  validates :label,
    presence: true,
    format: { with: LABEL_FORMAT },
    uniqueness: true

  def self.[](label)
    find_or_create_by_label(label)
  end
end

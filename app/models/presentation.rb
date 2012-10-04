class Presentation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :presentation_type
  validates :title, presence: true

  delegate :full_name, to: :user, prefix: true
end

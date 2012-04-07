class Presentation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates :title, presence: true

  delegate :full_name, to: :user, prefix: true
end

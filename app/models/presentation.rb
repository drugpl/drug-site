class Presentation < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :event

  validates :title, presence: true

  delegate :full_name, to: :user, prefix: true

  def as_json(*)
    {
      title: title,
      speakers: users.collect(&:full_name),
      event: event.as_json,
      postponed: cancelled
    }
  end
end

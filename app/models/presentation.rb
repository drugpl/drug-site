class Presentation < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :event

  validates :title, presence: true

  delegate :full_name, to: :user, prefix: true

  def as_json(*args)
    {
      title: title,
      speakers: users.collect(&:full_name),
      event: event.title.upcase,
      cancelled: cancelled,
      presented_at: event.starting_at.iso8601
    }
  end
end

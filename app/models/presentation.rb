class Presentation < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :event

  attr_protected

  validates :title, presence: true

  def users_full_names
    users.collect(&:full_name).join(', ')
  end

  def as_json(*)
    {
      title: title,
      speakers: users.collect(&:full_name),
      event: event.as_json,
      postponed: cancelled
    }
  end
end

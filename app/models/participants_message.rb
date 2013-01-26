class ParticipantsMessage < ActiveRecord::Base
  attr_accessible :event_id, :subject, :content

  belongs_to :event
  belongs_to :author, class_name: "Person"

  validates :event_id, :author_id, :subject, :content, presence: true
end
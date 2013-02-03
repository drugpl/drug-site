class Presentation < ActiveRecord::Base
  attr_accessible :title, :status
  
  belongs_to :event
  has_and_belongs_to_many :speakers, class_name: 'Person'

  validates :title, presence: true

  scope :submitted,     where(status: 'submitted')
  scope :postponed,     where(status: 'postponed')
  scope :not_postponed, where("status != 'postponed'")
  scope :done,          where(status: 'done')

  delegate :full_name, to: :person, prefix: true
  delegate :title, to: :event, prefix: true

  def postpone!
    self.status = 'postponed'
    save!
  end

  def cancel_postponement!
    self.status = 'submitted'
    save!
  end

  def postponed?
    status == 'postponed'
  end

  def lead_speaker
    speakers.first
  end
end

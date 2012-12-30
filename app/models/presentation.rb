class Presentation < ActiveRecord::Base
  belongs_to :speaker, class_name: 'Person'
  belongs_to :event
  validates :title, presence: true

  scope :submitted, where(status: 'submitted')
  scope :postponed, where(status: 'postponed')
  scope :done,      where(status: 'done')

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
end

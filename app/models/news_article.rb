class NewsArticle < ActiveRecord::Base
  include AASM

  aasm_initial_state :draft
  aasm_column :status
  
  aasm_state :draft
  aasm_state :published

  aasm_event :preview do
    transitions :from => :published, :to => :draft
  end

  aasm_event :publish do
    transitions :from => :draft, :to => :published
  end

  scope :published, where(:status => 'published')
  scope :draft, where(:status => 'draft')

  validates :title, :presence => true

  cattr_accessor :per_page  
  @@per_page = 5

  def body
    textilize(raw_body)
  end

  def raw_body
    self[:body]
  end

  def lead
    textilize(raw_lead)
  end

  def raw_lead
    self[:lead]
  end
end

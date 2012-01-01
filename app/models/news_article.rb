require 'textilized_attributes'

class NewsArticle < ActiveRecord::Base
  include TextilizedAttributes
  include AASM

  extend FriendlyId
  friendly_id :title, :use => :slugged

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

  textilized_attrs :body, :lead
end

class Contact < ActiveRecord::Base
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  attr_accessor :empty

  validates :email, :presence => true, :format => { :with => EMAIL_FORMAT }
  validates :name, :presence => true
  validates :message, :presence => true
  validate :empty_field

  after_create :send_notification

  private
  
  def empty_field
    errors[:base] << I18n.t('contacts.spam_protection') if self.empty.present?
  end

  def send_notification 
    ContactMailer.contact_message(self).deliver
  end
end

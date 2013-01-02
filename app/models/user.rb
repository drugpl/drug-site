class User < ActiveRecord::Base
  attr_accessible :full_name

  has_and_belongs_to_many :presentations

  validates :full_name, presence: true

  def presentations_count
    presentations.count
  end
end

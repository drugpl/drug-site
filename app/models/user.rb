class User < ActiveRecord::Base
  has_many :presentations

  validates :full_name, presence: true
end

class User < ActiveRecord::Base
  has_many :presentations

  validates :full_name, presence: true

  def description
    "Hi my name is and i like doing this and that :)"
  end
end

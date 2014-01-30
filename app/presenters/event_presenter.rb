class EventPresenter
  attr_accessor :event

  def initialize(event)
    @event = event
  end

  def as_json(*)
    {
      :id           => id,
      :title        => title,
      :description  => description,
      :starting_at  => starting_at,
    }
  end

  delegate :id, :title, :description, :starting_at, :to => :event
end

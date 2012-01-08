class EventsRemoveEndingAt < ActiveRecord::Migration
  def up
    remove_column :events, :ending_at
  end
end

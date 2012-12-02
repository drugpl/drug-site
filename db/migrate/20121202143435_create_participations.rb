class CreateParticipations < ActiveRecord::Migration
  def up
    create_table :participations do |t|
      t.integer :user_id
      t.integer :event_id
      
      t.timestamps
    end
  end

  def down
    drop_table :participations
  end
end

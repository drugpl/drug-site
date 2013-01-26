class CreateParticipantsMessages < ActiveRecord::Migration
  def up
    create_table :participants_messages do |t|
      t.integer :event_id
      t.integer :author_id
      t.string :subject
      t.text :content
    end
  end

  def down
    drop_table :participants_messages
  end
end

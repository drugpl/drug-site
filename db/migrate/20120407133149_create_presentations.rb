class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.string  :title
      t.references :user
      t.references :event
      t.timestamps
    end

    add_index :presentations, :user_id
    add_index :presentations, :event_id
  end
end

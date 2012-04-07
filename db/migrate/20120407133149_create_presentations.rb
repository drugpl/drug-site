class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.string  :title, null: false
      t.references :event, null: false
      t.boolean :cancelled, default: false, null: false
      t.timestamps null: false
    end

    add_index :presentations, :event_id
  end
end

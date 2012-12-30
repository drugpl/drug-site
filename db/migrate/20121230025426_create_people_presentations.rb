class CreatePeoplePresentations < ActiveRecord::Migration
  def up
    create_table :people_presentations do |t|
      t.integer :person_id, null: false
      t.integer :presentation_id, null: false
    end
  end

  def down
    drop_table :people_presentations
  end
end

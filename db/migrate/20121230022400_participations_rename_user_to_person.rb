class ParticipationsRenameUserToPerson < ActiveRecord::Migration
  def up
    rename_column :participations, :user_id, :person_id
  end

  def down
    rename_column :participations, :person_id, :user_id
  end
end

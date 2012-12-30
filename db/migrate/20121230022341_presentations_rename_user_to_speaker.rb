class PresentationsRenameUserToSpeaker < ActiveRecord::Migration
  def up
    rename_column :presentations, :user_id, :speaker_id
  end

  def down
    rename_column :presentations, :speaker_id, :user_id
  end
end

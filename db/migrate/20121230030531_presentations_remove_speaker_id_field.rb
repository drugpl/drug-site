class PresentationsRemoveSpeakerIdField < ActiveRecord::Migration
  def up
    remove_column :presentations, :speaker_id
  end

  def down
    add_column :presentations, :speaker_id, :integer
  end
end

class AddPhotoColumnsToVenues < ActiveRecord::Migration
  def self.up
    add_attachment :venues, :photo
  end

  def self.down
    remove_attachment :venues, :photo
  end
end

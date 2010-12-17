class VenuesAddLatitudeLongitudeFields < ActiveRecord::Migration
  def self.up
    change_table :venues do |t|
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
    end
  end

  def self.down
    change_table :venues do |t|
      t.remove :latitude
      t.remove :longitude
    end
  end
end

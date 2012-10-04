class CreatePresentationTypes < ActiveRecord::Migration
  def change
    create_table :presentation_types do |t|
      t.string :name

      t.timestamps
    end
  end
end

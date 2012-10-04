class AddTypeToPresentation < ActiveRecord::Migration
  def change
    add_column :presentations, :presentation_type_id, :integer
  end
end

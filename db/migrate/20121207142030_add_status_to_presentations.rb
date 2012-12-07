class AddStatusToPresentations < ActiveRecord::Migration
  def change
    # two paths
    # submitted -> done
    # submitted -> postponed
    add_column :presentations, :status, :string, default: 'submitted'
  end
end

class PeopleRemoveEmailNotNullConstraint < ActiveRecord::Migration
  def up
    change_column :people, :email, :string, null: true
    remove_index :people, name: 'index_users_on_email'
  end

  def down
    change_column :people, :email, :string, null: false
  end
end

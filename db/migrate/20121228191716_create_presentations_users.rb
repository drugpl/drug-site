class CreatePresentationsUsers < ActiveRecord::Migration
  def change
    create_table :presentations_users do |t|
      t.references :user, null: false
      t.references :presentation, null: false
    end
  end
end

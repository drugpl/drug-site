ActiveAdmin.register Presentation do
  index do
    column :title
    column :event
    column :cancelled
    column :users, :users_full_names
    default_actions
  end

  filter :title

  form do |f|
    f.inputs "Presentation Details" do
      f.input :title
      f.input :event
      f.input :cancelled
      f.input :users
    end
    f.actions
  end
end

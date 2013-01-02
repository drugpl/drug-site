ActiveAdmin.register User do
  index do
    column :full_name
    column :presentations, :presentations_count
    default_actions
  end

  filter :full_name

  form do |f|
    f.inputs "Admin Details" do
      f.input :full_name
      f.input :presentations
    end
    f.actions
  end
end

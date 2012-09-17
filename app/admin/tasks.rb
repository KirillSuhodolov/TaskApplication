ActiveAdmin.register Task do
  filter :title
  filter :created_at

  index do
    id_column
    column :title
    column :body_task
    column :answer
    column :created_at
    column :updated_at
    default_actions
  end
end

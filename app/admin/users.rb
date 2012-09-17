ActiveAdmin.register User do

  filter :email
  filter :created_at
  filter :counter

  index do
    id_column
    column :email
    column :counter
    column :created_at
    column :current_sign_in_at
    column :last_sign_in_at
    column :last_sign_in_ip
    column :created_at
    default_actions
  end
end
class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :currect_answer_user, :integer
    add_column :users, :submit_user, :integer
    add_column :users, :rating, :integer
  end
end

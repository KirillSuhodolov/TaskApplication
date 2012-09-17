class AddRatingColumnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :currect_answer_task, :integer
    add_column :tasks, :submit_task, :integer
  end
end

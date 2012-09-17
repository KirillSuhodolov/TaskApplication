class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, :nil => false, :default => ""
      t.text :body_task, :nil => false, :default => ""
      t.integer :user_id
      t.string :answer, :nil => false, :default => ""

      t.timestamps
    end
  end
end

class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.string   :task_id
      t.string   :user_id
      t.boolean  :currect_answer
      t.timestamps
    end
  end
end

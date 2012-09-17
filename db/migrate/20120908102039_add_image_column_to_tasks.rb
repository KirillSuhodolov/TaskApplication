class AddImageColumnToTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
    t.has_attached_file :image
    end
  end
end

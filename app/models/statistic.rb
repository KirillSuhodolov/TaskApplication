class Statistic < ActiveRecord::Base
  attr_accessible :task_id, :user_id, :currect_answer
  belongs_to :user
  belongs_to :task

end

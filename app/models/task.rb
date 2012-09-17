# encoding: UTF-8
class Task < ActiveRecord::Base
  acts_as_taggable_on :tags
  attr_accessible :body_task, :title, :tag_list, :image, :answer, :task_id, :user_id, :currect_answer
  belongs_to :user
  has_many :statistics

  #validation
  validates :title, :body_task, :presence => true
  validates :title, :uniqueness => true
  
  define_index do
    # fields
    indexes subject, :sortable => true
    indexes body_task
    indexes user.name, :as => :user, :sortable => true
    # attributes
    has id, created_at, updated_at
  end 

  #image to task
  has_attached_file :image, :styles => { :medium => "300x300", :thumb => "100x100" }
end
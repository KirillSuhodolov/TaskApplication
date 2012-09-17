# encoding: UTF-8
require 'paperclip'
class TasksController < ApplicationController
  before_filter :authenticate_user!
  # caches_action :index
  #creating tags cloud
  def tag_cloud
    @tags = Task.tag_counts_on(:tags)
  end
  #find by tags
  def tag
    @tasks = Task.paginate(:per_page => 3, :page => params[:page])
                 .tagged_with(params[:id])
    @tags  = Task.tag_counts_on(:tags)
    render :action => 'index'
    statistic = Statistic.user_id
  end

  #tags autocomplete
  def tags 
    @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{params[:q]}%") 
    respond_to do |format|
      format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name }}}
    end
  end

  def index
    sleep 0.2
    @tasks = Task.search(params[:search], 
             params[:query], :page => params[:page] || 1, :per_page => 5, 
             :include => :user, :match_mode => :boolean)
    @tags  = Task.tag_counts_on(:tags)
    respond_to do |format|
      format.js
      format.html 
      format.json { render json: @tasks }
    end
    tag_cloud
  end
 
  def show
    @task = Task.find(params[:id])
    respond_to do |format|
      format.html 
      format.json { render json: @task }
    end
  end

  def new
    @task = Task.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(params[:task])
    @task = current_user.tasks.build(params[:task])
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  def answer_add
    task = Task.where(:id => params[:id],
                      :answer => params[:answer])
    if task.empty?
      flash[:notice] = "Wrong answer"
      redirect_to task_path
    else 
      statistic = Statistic.create(:task_id => params[:id],
                                   :user_id => current_user.id, #User.find_by_id(session[:current_user_id]),
                                   :currect_answer => true)
      current_user.counter += 1
      current_user.save!
      flash[:notice] = "Congratulations! Correct answer"  
      redirect_to task_path
    end
  end
end

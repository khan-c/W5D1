class GoalsController < ApplicationController
  before_action :require_login

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goals_url
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def index
    #should return only public goals and current_user's goals
    @goals = Goal.where("private = ? OR user_id = ?", false, current_user.id)
    render :index
  end

  def show
    @goal = Goal.find(params[:id])

    if @goal
      render :show
    else
      # render json: "Page not found."
      redirect_to goals_url
    end
  end

  def edit
    @goal = current_user.goals.find(params[:id])

    if @goal
      render :edit
    else
      redirect_to goals_url
    end
  end

  def update
    @goal = current_user.goals.find(params[:id])
    # @goal.user_id = current_user.id
    if @goal.update_attributes(goal_params)
      redirect_to goals_url
    else
      flash.now[:errors] = @goals.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = current_user.goals.find(params[:id])
    @goal.destroy if @goal
    redirect_to goals_url
  end

  private
  def goal_params
    attributes = params.require(:goal).permit(:title, :body, :private)
    attributes[:private] = attributes[:private] == "true"
    attributes
  end
end

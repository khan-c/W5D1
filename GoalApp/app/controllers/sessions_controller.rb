class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      login!(@user)
      redirect_to goals_url
    else
      flash.now[:errors] = ["Invalid login credentials."]
      render :new
    end
  end

  # def edit
  # end
  #
  # def update
  # end
  #
  # def index
  # end
  #
  # def show
  # end

  def destroy
    logout!
    redirect_to new_session_url
  end
end

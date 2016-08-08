class UsersController < ApplicationController
  layout "login", except: [:index, :show]	

  before_action :logged_in_user

  def new
    @user = User.new
    render layout: "login" 
  end

  def show
  	@user = User.find(params[:id])
  end

  def login
  	#render layout: "login"
  end

  def create
    @user = User.new(user_params)  
    if @user.save
      log_in @user
      remember user
    	flash[:success] = "Bem vindo ao Devolve ae!!"
      redirect_to @user
    else
      render 'new'#, layout: 'login'
    end
  end



  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)

  end
end

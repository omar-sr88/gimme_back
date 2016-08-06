class UsersController < ApplicationController
  layout "login", except: [:index, :show]	

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
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
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

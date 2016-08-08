class UsersController < ApplicationController
  layout "login", except: [:index, :show, :edit, :update]	

  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def new
    if logged_in?
      redirect_to @current_user  
      return
    end 
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

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page], :per_page => 5)
  end 

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms a logged-in user.
   def logged_in_user
      unless logged_in?
         store_location
         flash[:danger] = "Please log in."
         redirect_to login_path
      end
   end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end

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
    return @user = User.find(params[:id]) if current_user.id.to_s == params[:id]
    if Item.are_users_related?(current_user.id,params[:id])
      @user = User.find(params[:id])
    else
      flash[:warning] = "Can't see unrelated people profiles!"
      redirect_to items_path
    end
  end

  def login
  	#render layout: "login"
  end

  def create
    @user = User.new(user_params)  
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page], :per_page => 5)
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

  def search
    @users = User.search(params[:search_text]) if !params[:search_text].blank?
    respond_to do |format|
      format.json { render :json => @users  }
    end
  end

  def check_username
    available = User.username_available(params[:username])
    respond_to do |format|
      format.json { render :json => available  }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, info_attributes: [:id, :phone_number])
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end

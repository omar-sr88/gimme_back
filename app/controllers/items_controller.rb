class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  layout "model-edit", only: [ :edit,:new ,:show]  
  before_action :set_locale

  # GET /items
  # GET /items.json
  def index
    @items = Item.all_with_flag(@current_user,params[:f])
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end 

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    byebug
    #need preparation and saving of GuestUser if its the case
    @item = Item.prepare_for_save(item_params,@current_user)

    respond_to do |format|
      if @item.save
        Notification.send_notification(@item, :create)
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        flash[:error] = "Couldnt update"
        flash[:model] = @item
        flash[:model_errors] = @item.errors
        format.html { redirect_to :action => :edit }
        
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def format_date(item)
     #l(item.date_lended.to_date)
  end

  def return
    @item = Item.find(params[:id])
    if !@item.is_owned_by?(@current_user)
      flash[:error] = "Could not returned that item"
      redirect_to items_url
    end
    if @item.update_columns(returned_date: Date.current,returned: true)
      Notification.send_notification(@item, :ret)
      flash[:success] = "Item returned successfully! Check history list to see it"
    else
      flash[:error] = "Could not return item."
    end
    redirect_to items_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      #byebug
      if flash[:model]
        @item = Item.find(flash[:model]["id"])
        @item.assign_attributes(flash[:model])
        flash[:model_errors].each do |k,v|
          @item.errors.add(k,v[0])
        end
        @item.date_lended =  I18n.localize @item.date_lended if @item.date_lended
        @item.initial_return_date = I18n.localize @item.initial_return_date if @item.initial_return_date  
        flash.clear
        @item
      else
        @item = Item.find(params[:id])
        @item.date_lended =  I18n.localize @item.date_lended if @item.date_lended
        @item.initial_return_date = I18n.localize @item.initial_return_date if @item.initial_return_date  
      end

     
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :date_lended, :initial_return_date, :recipient_email, :is_guest ,:guest_recipient, :guest_phone , :image)
    end
end

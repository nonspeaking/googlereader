require 'rho/rhocontroller'

class ItemController < Rho::RhoController

  #GET /Item
  def index
    if SyncEngine::logged_in > 0
      @items = Item.find(:all).sort {|a,b| b.timestamp <=> a.timestamp}
      render
    else
      redirect :controller=>"Settings", :action=>"login"
    end
  end

  # GET /Item/1
  def show
    @item = Item.find(@params['id'])
    unless @item.read == "true"
      @item.update_attributes("read"=>"true")
    end
    render :action => :show
  end

  # GET /Item/new
  def new
    @item = Item.new
    render :action => :new
  end

  # GET /Item/1/edit
  def edit
    @item = Item.find(@params['id'])
    render :action => :edit
  end

  # POST /Item/create
  def create
    @item = Item.new(@params['item'])
    @item.save
    redirect :action => :index
  end

  # POST /Item/1/update
  def update
    @item = Item.find(@params['id'])
    @item.update_attributes(@params['item'])
    redirect :action => :index
  end

  # POST /Item/1/delete
  def delete
    @item = Item.find(@params['id'])
    @item.destroy
    redirect :action => :index
  end
end

class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    

  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end


  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "The information has been successfully updated"
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
    else
      render :edit
    end
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_item
    @item = @merchant.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

 def enable
  item = Item.find(params[:id])
  item.update(active: true)
  redirect_to "/merchants/#{params[:merchant_id]}/items"
  end

  def disable
    item = Item.find(params[:id])
    item.update(active: false)
    redirect_to "/merchants/#{params[:merchant_id]}/items"
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(item_params)
    
    if @item.save
      redirect_to "/merchants/#{params[:merchant_id]}/items"
    else
      render :new
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :active)
  end
  

end
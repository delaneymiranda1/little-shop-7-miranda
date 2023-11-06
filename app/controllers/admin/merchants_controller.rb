class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def disable
    merchant = Merchant.find(params[:id])
    merchant.update(enabled: false)
    redirect_to '/admin/merchants'
  end

  def enable
    merchant = Merchant.find(params[:id])
    merchant.update(enabled: true)
    redirect_to '/admin/merchants'
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    if @merchant.update(merchant_params)
      flash[:notice] = "The information has been successfully updated"
      redirect_to "/admin/merchants/#{@merchant.id}"
    else
      render :edit
    end
  end

  def merchant_params
    params.require(:merchant).permit(:name)
  end

   def find_merchant
    @merchant = Merchant.find(params[:id] || params[:merchant_id])
  end

end
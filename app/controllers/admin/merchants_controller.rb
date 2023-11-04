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

end
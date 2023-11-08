class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end
  
  def show
    @merchant = Merchant.find(params[:id])
  end

  def new 
  end

  def create
    merchant = Merchant.create!(name: params[:name])
    merchant.update(enabled: false)

    redirect_to "/admin/merchants"
  end

  def edit
    # require 'pry'; binding.pry
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if params[:flip]
      @merchant.send(params[:enable])
      redirect_to '/admin/merchants'
    else
      if @merchant.update(merchant_params)
        flash[:notice] = "The information has been successfully updated"
        redirect_to "/admin/merchants/#{@merchant.id}"
      else
        render :edit
      end
    end
  end

  def merchant_params
    params.require(:merchant).permit(:name)
  end

  def find_merchant
    @merchant = Merchant.find(params[:id] || params[:merchant_id])
  end

end
class BulkDiscountsController < ApplicationController 

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    BulkDiscount.create!(bulk_discount_params)
    redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts"
  end

  def edit
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update 
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.update!(quantity: params[:bulk_discount][:quantity], discount: params[:bulk_discount][:discount])

    redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts/#{params[:id]}"
  end

  def destroy
    BulkDiscount.destroy(params[:id])
    redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts"
  end

  private
  def bulk_discount_params
    params.permit(:quantity, :discount, :merchant_id)
  end
end
class Merchants::InvoicesController < ApplicationController
    
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
    @invoice_items = @invoice.invoice_items
    if @invoice_items.update(invoice_items_params)
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    else
      render :edit
    end
  end

  private
  def invoice_items_params
    params.require(:invoice_item).permit(:quantity, :unit_price, :status)
  end
end
class Merchants::InvoicesController < ApplicationController
    
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.includes(:items)
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
    @items = @invoice.items
    @invoice_items = @invoice.invoice_items.includes(:item)
    @total_revenue = @invoice.invoice_items.sum('unit_price * quantity')
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
    @invoice_items = @invoice.invoice_items.includes(:item)
    if @invoice_items.update(invoice_items_params)
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    else
      render :edit
    end
  end

  def invoice_items_params
    params.require(:invoice_item).permit(:quantity, :unit_price, :status)
  end
end
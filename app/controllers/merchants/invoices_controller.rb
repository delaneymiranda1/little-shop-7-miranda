class Merchants::InvoicesController < ApplicationController
    
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
  end

  def update
    @invoice_item = InvoiceItem.find(params[:id])
    if @invoice_item.update(invoice_items_params)
      redirect_to "/merchants/#{@invoice_item.item.merchant_id}/invoices/#{@invoice_item.invoice_id}"
    end
  end

  private
  def invoice_items_params
    params.require(:invoice_item).permit(:quantity, :unit_price, :status)
  end
end
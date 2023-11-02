class Merchants::InvoicesController < ApplicationController
 
    
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.includes(:items)
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:invoice_id])
  end


end
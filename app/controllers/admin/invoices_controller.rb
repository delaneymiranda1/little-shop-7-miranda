class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end
  
  def show
    @invoice = Invoice.find(params[:invoice_id])
    @items = @invoice.items
    @invoice_items = @invoice.invoice_items.includes(:item)
    @total_revenue = @invoice.invoice_items.sum('unit_price * quantity')
  end

  def update
    @invoice = @merchant.invoices.find(params[:invoice_id])
    if @invoice.update(invoice_params)
      redirect_to "/admin/invoices/#{@invoice.id}"
    else
      render :edit
    end
  end

  
  def invoice_params
    params.require(:invoice).permit(:status)
  end
end
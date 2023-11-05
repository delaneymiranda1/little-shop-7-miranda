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
end
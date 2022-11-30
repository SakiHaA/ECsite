class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
  @cart_items = CartItem.where(customer_id: current_customer.id )
    @order = Order.new(order_params)
    @address=(params[:order][:select_address])
    @order.postage = 800
    if @address == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif  @address=(params[:order][:select_address]) == "2"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.build
    @total = 0

  end


  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = CartItem.where(customer_id: current_customer.id )
    @cart_items.each do |cart_item|
      @order_product = OrderProduct.new
      @order_product.order_id = @order.id
      @order_product.item_id = cart_item.item_id
      @order_product.item = cart_item.item
      @order_product.quantity = cart_item.amount
      @order_product.price = @order.total
      @order_product.production_status = 0
      @order_product.save
    end
     @cart_items.delete_all
    redirect_to complete_orders_path
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
  end


private
  def order_params
    params.require(:order).permit(:pay_method, :postal_code, :address, :name, :postage, :total)
  end

end

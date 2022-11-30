class Admin::OrdersController < ApplicationController
  def show
    @order =  Order.find(params[:id])
    @order_products = @order.order_products
    @total = 0
    @order_products.each do |order_product|
      @total += (order_product.item.price * 1.1 * order_product.quantity).floor
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.order_status == "confirmation"
      @order.order_products.update(production_status: "waiting")
    end
    redirect_to admin_order_path(@order.id)
  end


  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
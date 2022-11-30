class Admin::OrderProductsController < ApplicationController
  def update
    @order_product = OrderProduct.find(params[:id])
    @order_product.update(order_product_params)
    @order = @order_product.order

    if
      @order_product.production_status == "make"
      @order.update(order_status: "make")

    elsif
      @order.order_products.count == @order.order_products.where(production_status: "finish").count
      @order.update(order_status: "ready")
    end
      redirect_to request.referrer
  end

  private

  def order_product_params
    params.require(:order_product).permit(:production_status)
  end

  def order_params
    params.require(:order).permit(:order_status)
  end
end
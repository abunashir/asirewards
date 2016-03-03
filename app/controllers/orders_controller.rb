class OrdersController < ApplicationController
  before_action :require_login

  def index
    @orders = current_user.orders
  end

  def new
    @order = current_user.orders.new
  end

  def create
    @order = current_user.orders.new(order_params)

    if @order.save
      redirect_to orders_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:certificate_id, :quantity, :note)
  end
end

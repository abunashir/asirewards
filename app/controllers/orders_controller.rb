class OrdersController < ApplicationController
  before_action :require_login

  def index
    @orders = order_scope
  end

  def show
    @order = order_scope.find(params[:id])
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

  def update
    order = order_scope.find(params[:id])

    if order.approve
      redirect_to orders_path
    else
      redirect_to order_path(order)
    end
  end

  private

  def order_scope
    if current_user.management_admin?
      Order.pending
    else
      current_user.orders
    end
  end

  def order_params
    params.require(:order).permit(:certificate_id, :quantity, :note)
  end
end

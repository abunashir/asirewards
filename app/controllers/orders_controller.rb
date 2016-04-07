class OrdersController < ApplicationController
  before_action :require_login

  def index
    @orders = orders.recent
  end

  def new
    @order = orders.new
  end

  def create
    @order = orders.new(order_params)

    if @order.save
      redirect_to orders_path, notice: I18n.t("order.create.success")
    else
      render :new
    end
  end

  private

  def orders
    current_user.orders
  end

  def order_params
    params.require(:order).permit(:certificate_id, :quantity, :note)
  end
end

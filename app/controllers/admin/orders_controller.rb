class Admin::OrdersController < ApplicationController
  before_action :require_login
  before_action :require_management_admin

  layout "application.admin"

  def index
    @orders = Order.recent
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.pending.find(params[:id])

    if order.approve
      redirect_to admin_orders_path, notice: I18n.t("order.approve.success")
    else
      redirect_to admin_order_path(order), notice: I18n.t("order.approve.errors")
    end
  end
end

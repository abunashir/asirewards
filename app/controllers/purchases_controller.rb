class PurchasesController < ApplicationController
  def index
  end

  def show
    @purchase = purchases.new
    @purchase.build_user
  end

  def update
    @purchase = purchases.new
    process_purchase || render(:show)
  end

  private

  def purchases
    certificate.purchases
  end

  def certificate
    @certificate = Certificate.friendly.find(params[:id])
  end

  def process_purchase
    set_purchase_attributes

    if @purchase.save && @purchase.create_payment
      session[:purchase_id] = @purchase.id
      redirect_to @purchase.payment_gateway_url
    end
  end

  def set_purchase_attributes
    if existing_user
      @purchase.user = existing_user
    else
      @purchase.attributes = purchase_params
    end
  end

  def existing_user
    @user ||= User.find_by_email(purchase_params[:user_attributes][:email])
  end

  def purchase_params
    params.require(:purchase).permit(
      user_attributes: [:name_part_one, :name_part_two, :phone, :email]
    )
  end
end

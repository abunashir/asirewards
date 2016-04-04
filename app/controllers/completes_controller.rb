class CompletesController < ApplicationController
  def show
    @purchase = Purchase.find(session[:purchase_id])
    execute_payment || redirect_to(purchases_url)
  end

  private

  def execute_payment
    if @purchase.execute_payment(params[:PayerID])
      session[:purchase_id] = nil
      @purchase.finalize_purchase
    end
  end
end

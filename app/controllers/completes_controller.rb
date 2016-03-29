class CompletesController < ApplicationController
  def show
    purchase = Purchase.find(session[:purchase_id])

    if purchase.execute_payment(params[:PayerID])
      purchase.deliver_certificate
      session[:purchase_id] = nil
    else
      redirect_to purchases_url
    end
  end
end

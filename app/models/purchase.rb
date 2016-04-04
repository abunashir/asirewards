class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :certificate

  accepts_nested_attributes_for :user
  attr_reader :payment

  def create_payment
    @payment = PayPal::SDK::REST::Payment.new(payment_options)

    if @payment.create
      update! payment_id: @payment.id
    end
  end

  def execute_payment(payer_id)
    @payment = find_payment
    @payment.execute(payer_id: payer_id)
  end

  def payment_gateway_url
    payment.links.find{|v| v.method == "REDIRECT" }.href
  end

  def finalize_purchase
    update paid: true
    certificate.send_certificate(user: user)
  end

  private

  def find_payment
    PayPal::SDK::REST::Payment.find(payment_id)
  end

  def payment_options
    {
      intent: "sale",
      payer: { payment_method: "paypal"},
      transactions: [{
        amount: {
          total: item_price,
          currency: "USD"
        },

        item_list: {
          items: [{
            name: item_name,
            price: item_price,
            quantity: 1,
            currency: "USD"
          }]
        },

        description: "#{item_name} Certificate"
      }],

      redirect_urls: {
        return_url: "#{app_url}/purchases/#{certificate.slug}/complete",
        cancel_url: "#{app_url}/purchases"
      }
    }
  end

  def item_price
    sprintf("%.2f", certificate.price || 1)
  end

  def item_name
    certificate.name
  end

  def app_url
    "http://#{ENV["APPLICATION_HOST"]}"
  end
end

module PaypalApiHelper
  def stub_create_token_request
    stub_request(:post, paypal_token_api).
      to_return(response_with(file: "token", status: 200))
  end

  def stub_create_payment_request
    stub_request(:post, paypal_payment_path).
      to_return(response_with(file: "create_payment", status: 201))
  end

  def stub_find_payment_request(payment_id)
    stub_request(:get, paypal_payment_path(payment_id)).
      to_return(response_with(file: "payment", status: 200))
  end

  def stub_execute_payment_request(payment_id)
    stub_request(:post, [paypal_payment_path(payment_id), "execute"].join("/")).
      to_return(response_with(file: "payment", status: 200))
  end

  private

  def response_with(file:, status:)
    { body: fixture_file(file), status: status, headers: response_header }
  end

  def fixture_file(filename)
    file_path = ["spec", "support", "fixtures", "#{filename}.json"].join("/")
    File.read file_path
  end

  def response_header
    {"content-type": "application/json"}
  end

  def paypal_payment_path(payment_id = nil)
    base_path = "https://api.sandbox.paypal.com/v1/payments/payment"
    [base_path, payment_id].compact.join("/")
  end

  def paypal_token_api
    user = [ENV["PAYPAL_CLIENT_ID"], ENV["PAYPAL_CLIENT_SECRET"]].join(":")
    "https://#{user}@api.sandbox.paypal.com/v1/oauth2/token"
  end
end

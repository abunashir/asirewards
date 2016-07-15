module PurchasesHelper
  def certificate_retail_price(certificate_slug)
    certificate = Certificate.find_by(slug: certificate_slug)

    if certificate
      number_to_currency(certificate.price, unit: "$", precision: 0)
    end
  end
end

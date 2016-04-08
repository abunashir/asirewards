class ApplicationMailer < ActionMailer::Base
  default from: "info@impactrewards.io"
  layout 'mailer'

  private

  def company_support_staff
    staff_id = ENV["SUPPORT_STAFF_ID"]
    staff_id ? User.find(staff_id) : User.first
  end
end

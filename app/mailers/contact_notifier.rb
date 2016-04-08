class ContactNotifier < ApplicationMailer
  default from: "ASI Rewards <noreply@asirewards.io>"

  def notify_staff(contact_id)
    @staff = company_support_staff
    @contact = Contact.find(contact_id)
    mail to: @staff.email, subject: "Pending contact request"
  end

  def notify_sender(contact_id)
    @contact = Contact.find(contact_id)
    mail to: @contact.email, subject: "We've received your contact request"
  end
end

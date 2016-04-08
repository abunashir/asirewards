class ContactsController < ApplicationController
  def create
    contact = Contact.new contact_params

    if contact.save
      contact.deliver_emails
      redirect_to root_path, notice: I18n.t("contact.create.success")
    else
      flash[:error] = I18n.t("contact.create.errors")
      redirect_to root_path
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end

require "rails_helper"

describe ContactNotifier do
  describe ".notify_staff" do
    it "sends the sender details to the staff" do
      admin = create(:admin)
      contact = create(:contact)

      email = ContactNotifier.notify_staff(contact.id)

      expect(email.subject).to include("Pending contact request")
      expect(email.from).to eq(["noreply@asirewards.io"])
      expect(email.to).to include(admin.email)

      expect(email.body.encoded).to include(contact.name)
      expect(email.body.encoded).to include(contact.email)
      expect(email.body.encoded).to include(contact.message)
    end
  end

  describe ".notify_sender" do
    it "sends a confirmation to the sender" do
      contact = create(:contact)
      email = ContactNotifier.notify_sender(contact.id)

      expect(email.subject).to include("We've received your contact request")
      expect(email.from).to eq(["noreply@asirewards.io"])
      expect(email.to).to include(contact.email)

      expect(email.body.encoded).to include(contact.name)
      expect(email.body.encoded).to include("We are in receipt of your contact")
    end
  end
end

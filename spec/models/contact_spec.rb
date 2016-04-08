require "rails_helper"

describe Contact do
  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :message }
  end

  describe "#deliver_emails" do
    include ActiveJob::TestHelper

    it "sends the email to the admin staff" do
      create(:admin)
      contact = create(:contact)

      contact.deliver_emails

      expect(enqueued_jobs.size).to eq(2)
      expect(enqueued_jobs.last[:job]).to eq(ActionMailer::DeliveryJob)
      expect(enqueued_jobs.last[:args].first).to eq("ContactNotifier")
      expect(enqueued_jobs.last[:args].last).to eq(contact.id)
    end
  end
end

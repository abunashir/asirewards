class Contact < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true

  def deliver_emails
    ContactNotifier.notify_staff(self.id).deliver_later
    ContactNotifier.notify_sender(self.id).deliver_later
  end
end

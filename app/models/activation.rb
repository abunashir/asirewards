class Activation < Kit
  attr_accessor :activation_code

  def activate
    self.activated_on = Time.current
    save
  end

  def activated?
    used? && activated_on.present?
  end

  def deliver_confirmation
    ActivationConfirmation.release(self.id).deliver_later
  end

  def self.pending
    where(used: true, activated_on: nil)
  end

  def self.find_by_code(activation_code)
    kit_code= activation_code.split(//).last(7).join
    pending.where(code: kit_code).last
  end
end

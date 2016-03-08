module FlashesHelper
  def user_facing_flashes
    flash.to_hash.slice("alert", "error", "notice", "success")
  end

  def key_to_bootstrap_class(key)
    case key.to_s
    when "notice"
      "success"
    when "error"
      "danger"
    end
  end
end

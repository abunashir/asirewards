class Account < Company
  def admin
    users.where(admin: true).last
  end
end

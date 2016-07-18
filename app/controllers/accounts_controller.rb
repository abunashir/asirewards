class AccountsController < ApplicationController
  def new
    @account = Account.new
    @account.users.build
  end

  def create
    create_account || render(:new)
  end

  private

  def account
    @account ||= Account.new(account_params)
  end

  def create_account
    if account.save
      sign_in(account.admin)
      redirect_to(marketer_path, notice: I18n.t("account.create.success"))
    end
  end

  def account_params
    params.require(:account).permit(
      :name, users_attributes: [:name, :email, :password, :admin]
    )
  end
end

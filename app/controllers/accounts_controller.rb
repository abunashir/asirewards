class AccountsController < ApplicationController
  def new
    @account = Account.new
    @account.users.build
  end

  def create
    @account = Account.new account_params

    if @account.save
      sign_in(@account.admin)
      redirect_to root_path, notice: I18n.t("account.create.success")
    else
      render :new
    end
  end

  private

  def account_params
    params.require(:account).permit(
      :name, users_attributes: [:name, :email, :password, :admin]
    )
  end
end

class Account::ProductsController < ApplicationController
  before_action :authenticate_user!
  layout "account"

  def index
    @products = current_user.collections
  end
end

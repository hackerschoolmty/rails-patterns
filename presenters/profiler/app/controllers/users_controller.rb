class UsersController < ApplicationController
  def show
    @user = current_user
  end

  private

    def current_user
      [User.find(params[:id]), nil].sample
    end
end

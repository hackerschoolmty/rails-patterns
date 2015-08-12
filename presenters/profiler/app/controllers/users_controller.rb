class UsersController < ApplicationController
  def show
    @user_decorator = UserDecorator.new(current_user)
  end

  private

    def current_user
      [User.find(params[:id]), nil].sample
    end
end

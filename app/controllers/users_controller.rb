class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search_friend
    if params[:input]
      @users = User.search_email_or_name(params[:input])
      redirect_to my_friends_path
    else
      redirect_to my_friends_path
    end
  end
end

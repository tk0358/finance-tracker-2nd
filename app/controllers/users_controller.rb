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

<<<<<<< HEAD
  def search
    if params[:friend].present?
      @users = User.search(params[:friend])
      @users = current_user.except_current_user(@users)
      if @users
=======
  def search_friend
    if params[:input].present?
      @users = User.search_email_or_name(params[:input])
      if !@users.empty?
>>>>>>> c714828cdda3503135b695811cf31fb906f71fa3
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
<<<<<<< HEAD
          flash.now[:alert] = "Couldn't find user"
=======
          flash.now[:alert] = "No users found"
>>>>>>> c714828cdda3503135b695811cf31fb906f71fa3
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
<<<<<<< HEAD
        flash.now[:alert] = "Please enter name or email to search"
=======
        flash.now[:alert] = "Please input name or email"
>>>>>>> c714828cdda3503135b695811cf31fb906f71fa3
        format.js { render partial: 'users/friend_result' }
      end
    end
  end
end

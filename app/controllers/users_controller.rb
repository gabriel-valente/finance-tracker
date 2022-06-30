class UsersController < ApplicationController
  def portfolio
    @tracked_stocks = current_user.stocks
  end

  def friends
    @friends = current_user.friends
  end

  def search
    if params[:user].present?
      @users = User.search params[:user]
      @users = current_user.except_current_user(@users)

      if !@users.empty?
        respond_to do |format|
          format.js { render partial: "friends/result" }
        end
      else
        respond_to do |format|
          @users = nil
          flash.now[:alert] = "User not found."
          format.js { render partial: "friends/result" }
        end
      end    
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search."
        format.js { render partial: "friends/result" }
      end
    end
  end
end

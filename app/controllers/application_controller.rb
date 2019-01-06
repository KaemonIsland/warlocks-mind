class ApplicationController < ActionController::Base
  include DeviseWhitelist

    def index_view
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user.id == @user.id
    end
end

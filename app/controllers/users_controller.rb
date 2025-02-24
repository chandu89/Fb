class UsersController < ApplicationController
  def index
    if params[:query].present?
      @users = User.search(params[:query], fields: [:first_name, :last_name], match: :word_start)
    else
      @users = User.all
    end
    respond_to do |format|
      format.html # regular request
      format.json { render json: { results: @users.map { |user| {user_id: user.id, first_name: user.first_name, last_name: user.last_name } } } }
    end
  end
end

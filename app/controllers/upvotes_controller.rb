class UpvotesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  def create
    @votable = find_upvotable
    current_user.like(@votable)
    respond_to do |format|
     format.js
     format.html { redirect_to root_path }
    end
  end

  def destroy
    @votable = find_upvotable
    current_user.unlike(@votable)

    respond_to do |format|
      format.js
      format.html { redirect_to root_path }
    end
  end

  private

  def find_upvotable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end
end

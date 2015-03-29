class UpvotesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  def create
    @votable = find_upvotable
    @vote = @votable.upvotes.build(user_id: current_user.id)
      if @vote.save
        respond_to do |format|
        format.js
        format.html { redirect_to root_path }
        end
     end
  end

  def destroy
    @votable = find_upvotable
    @vote = @votable.upvotes.find_by(user_id: current_user.id)
    respond_to do |format|
      if @vote.destroy
        format.js
        format.html { redirect_to root_path }
      end
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

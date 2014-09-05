class LikesController < ApplicationController

  before_action :authenticate_user!
  def create
    @like = current_user.likes.build(pin_id: params[:pin_id])
    render :json => {:result => @like.save}
  end

  def destroy
    render :json => {:result => Like.find(params[:id]).destroy}
  end
end
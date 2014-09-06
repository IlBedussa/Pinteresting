class LikesController < ApplicationController

  before_action :authenticate_user!
  def create
    @like = current_user.likes.build(pin_id: params[:pin_id])
    @like.save
    @pin = Pin.find(params[:pin_id]);
#    render :template =>  "pins/_pin" ,:locals => {:pin => @pin}
    render :partial =>"pins/pin", :locals => {:pin => @pin}
  end

  def destroy
    pinId = Like.find(params[:id]).pin_id
    Like.find(params[:id]).destroy
    @pin = Pin.find(pinId)
    render :partial =>"pins/pin", :locals => {:pin => @pin}
  end
end
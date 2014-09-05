class LikesController < ApplicationController
  
  before_action :authenticate_user!
  
  def create
    @like = pins.likes.build(like_params)
    if @like.save
      puts "Created"
      render :json => "success"
    else
      puts "failed"
      render :json => "failed"
    end
    
  end
  
  def destroy
    @pin.destroy
    redirect_to pins_url
  end
  
  private
  def like_params
    params.permit(:pin_id)
  end
  
end
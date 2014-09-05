class LikesController < ApplicationController
  
  before_action :authenticate_user!
  
  def create
    @pin = pins.where(id: pin_id);
    
    @like = current_user.pins.likes.build(like_params)
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
    params.permit(current_user.id, :pin_id)
  end
  
end
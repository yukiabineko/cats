class SchedulesController < ApplicationController
  
  def show
    @user = User.find(params[:user_id])
    @cat = Cat.find(params[:id])
    @schedule = @cat.schedules.new
  end
end

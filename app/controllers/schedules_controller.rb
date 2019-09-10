class SchedulesController < ApplicationController
  
#表示して  
  def show
    @user = User.find(params[:user_id])
    @cat = Cat.find(params[:id])
    @schedule = @cat.schedules.new
    @schedules = Schedule.all.paginate(page:params[:page])
  end
  
  def create
     @schedules = Schedule.all.paginate(page:params[:page])
     @cat = Cat.find(params[:schedule][:cat_id])
     @schedule = @cat.schedules.new(parameter)
     if @schedule.save
       redirect_to plan_show_url(@cat,@cat.user)
     else
       render:show
     end   
  end

private
  def parameter
    params.require(:schedule).permit(:plan_date, :plan_content,:cat_id)
  end
end

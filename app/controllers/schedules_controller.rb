class SchedulesController < ApplicationController
  
#表示して  
  def show
    @user = User.find(params[:user_id])
    @cat = Cat.find(params[:id])
    @schedule = @cat.schedules.new
    @schedules = Schedule.paginate(page:params[:page],:per_page => 5).where(cat_id: @cat.id).order('plan_date asc')
  end
#登録  
  def create
     @cat = Cat.find(params[:schedule][:cat_id])
     @schedules = Schedule.paginate(page:params[:page],:per_page => 5).where(cat_id: @cat.id).order('plan_date asc')
     @schedule = @cat.schedules.new(parameter)
     if @schedule.save
       redirect_to plan_show_url(@cat,@cat.user)
     else
       render:show
     end   
  end
#アップデート
  def update
    @cat = Cat.find(params[:cat_id])
    plan_parameter.each do |id,item|
      schedule = Schedule.find id
      schedule.update_attributes(item)
    end    
     redirect_to plan_show_url(@cat,@cat.user)
  end
#削除
 def destroy
   @schedule =Schedule.find(params[:id])
   @schedule.destroy
   redirect_to plan_show_url(@schedule.cat,@schedule.cat.user)
   
 end
private
  def parameter
    params.require(:schedule).permit(:plan_date, :plan_content,:cat_id)
  end
  def plan_parameter
    params.permit(plans:[:plan_date, :plan_content])[:plans]
  end
end

class SchedulesController < ApplicationController
  before_action :cat_user,only:[:show,:correct_user]
  before_action :correct_user,only:[:show]
  
#表示して  
  def show
    @user = User.find(params[:user_id])
    @cat = Cat.find(params[:id])
    @schedule = @cat.schedules.new
    @schedules = Schedule.paginate(page:params[:page],:per_page => 10).where(cat_id: @cat.id).order('plan_date asc')
  end
#登録  
  def create
     @cat = Cat.find(params[:schedule][:cat_id])
     @schedules = Schedule.paginate(page:params[:page],:per_page => 5).where(cat_id: @cat.id).order('plan_date asc')
     @schedule = @cat.schedules.new(parameter)
       redirect_to user_url(@cat.user)
    
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
#ユーザー
 def cat_user
   @user = User.find(params[:user_id])
 end
#ログインユーザー自身以外の猫ページアクセス禁止  
  def correct_user
      redirect_to(root_url) unless current_user?(@user)
  end
end

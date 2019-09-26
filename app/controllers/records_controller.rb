class RecordsController < ApplicationController
  before_action :admin_page
  before_action:roop,only: :cats_weight
  before_action:correct_user,only:[:lasted_weight,:cats_weight] 
  
  def show
    
    @cats =current_user.cats.all if current_user.present?
    #個別選択
    if params[:select]
      @cat = current_user.cats.find_by(cat_name: params[:select]) if current_user.present?
    #初回showアクセス用  
    else
      @cat = Cat.new
    end  
    @array = set_array if @cats.present?
    
  end
#------------------------------------------------------------------------------------------------
  def result_view
     @all_cats =current_user.cats.all if current_user.present? #ユーザー猫総数
    #体重結果ページ更新ボタン押された場合の処理
    if request.get? && logged_in? 
      redirect_to record_url
    end   
    if logged_in?   
    #猫複数形パラメーター
    @obj ={}
      if params[:records]
        cats_multiple_parameter.each do |id,item|
          @cats={}
          cat = Cat.find id
          #１歳以上の猫        
          if cat.cat_age >1.2
            obj= Base.find_by(data_age: 1.2)
          #1才未満          
          elsif cat.cat_age <=1.0
         #ここが複雑        
            obj= Base.find_by(data_age: params[:records][id][:cat_age])
          end
          min_weight = obj.min_weight
            max_weight = obj.max_weight
            if cat.cat_weight < min_weight
              str = "痩せてます"
            elsif  cat.cat_weight >max_weight
              str = "太ってます"
            elsif cat.cat_weight >= min_weight && cat.cat_weight<= max_weight
              str = "標準です"    
            end
          @cats[:id] = cat.id
          @cats[:date] = Date.today
          @cats[:name] = cat.cat_name
          @cats[:weight] = cat.cat_weight
          @cats[:data_weight] = "#{min_weight}~#{max_weight}"
          @cats[:result] = str
          @obj[id]=@cats  #各猫配列をさらに配列格納
        end    
      #猫単数パラメーター      
      elsif params[:name]
        @id = params[:id]
        @cat = Cat.find(params[:id])
        @date = Date.today
        #1才以上の猫      
        if @cat.cat_age > 1.2
          obj = Base.find_by(data_age: 1.2)
        elsif @cat.cat_age <= 1.0 
          obj = Base.find_by(data_age: params[:age])  
        end
        min_weight = obj.min_weight
        max_weight = obj.max_weight
        @data_weight = "#{min_weight}~#{max_weight}"
        if @cat.cat_weight < min_weight
          @result = "痩せてます"
        elsif  @cat.cat_weight > max_weight
          @result ="太ってます"
        else
            @result = "標準です"    
        end
      #登録猫なしの時(login済み)      
      elsif @all_cats.count == 0
          if params[:cat_weight].present?
            @date =Date.today 
            @name = "#{current_user.name}さんの猫"
            obj = Base.find_by(data_age: params[:cat_age])
            min_weight = obj.min_weight
            max_weight = obj.max_weight
            @data_weight = "#{min_weight}~#{max_weight}"
            if params[:cat_weight].to_f < min_weight
              @result = "痩せてます"  
            elsif params[:cat_weight].to_f > max_weight  
              @result ="太ってます"
            else  
              @result = "標準です" 
            end  
          #体重未入力の処理  
          else
            flash[:danger] = "体重を入力してください"
          end    
      
      end 
  #-------------------------------------------------------------    
  #未ログイン  
    else
       if params[:cat_weight].present?
        @date =Date.today
        @name ="ゲストさんの猫"
        obj = Base.find_by(data_age: params[:cat_age])
        min_weight = obj.min_weight
        max_weight = obj.max_weight
        @data_weight = "#{min_weight}~#{max_weight}"
        if params[:cat_weight].to_f < min_weight
          @result = "痩せてます"
        elsif params[:cat_weight].to_f > max_weight
          @result ="太ってます"
        else
            @result = "標準です"    
        end   
      #体重未入力の処理
       else
        flash[:danger] = "体重を入力してください"
        redirect_to record_url
       end  
    end  
  end
#========================================================  
  def create
     #猫複数登録時  
     if params[:saves]
        save_parameters.each do |id,item|
          cat = Cat.find(item[:cat_id])
          obj = cat.records.build(item)
          obj.save
        end
         redirect_to root_path
     else    
       cat = Cat.find(params[:cat_id])
       obj = cat.records.new(save_parameter)
       obj.save
       redirect_to root_path
     end  
  end
#========================================================== 
#最新の猫体重チェック表
 def lasted_weight
   @user = User.find(params[:user_id])
   @cats = @user.cats.all
   @data = non_data?
   
 end
#各猫の体重チェック全て表示 
def cats_weight
  @cat = Cat.find(params[:cat_id])
  @records = @cat.records.where(cat_id: params[:cat_id])
end 
#全各猫体重記録データ全削除
 def all_reset
   @cat = Cat.find(params[:cat_id])
   @cat.records.all.destroy_all
   redirect_to lasted_weight_url @cat.user
 end
#全各猫体重記録データ個別削除 
def reset
  @record = Record.find(params[:record_id])
  @record.destroy
   redirect_to lasted_weight_url @record.cat.user
end
#-----------------------------------------------------------------------------------
private

#猫単数パラメーター
  def cats_multiple_parameter
    params.permit(records:[:id,:name,:age,:weight])[:records]
  end
#猫単数パラメーター
  def cat_single_parameter
    params.permit(:id,:name,:age,:weight)
  end
#猫検査登録複数パラメーター
  def save_parameters
    params.permit(saves:[:cat_id, :save_date, :ideal_weight, :result_weight, :result])[:saves]
  end
#猫検査登録複数パラメーター
  def save_parameter
    params.permit(:cat_id, :save_date, :ideal_weight, :result_weight, :result)
  end  
#データがない場合rootへリダイレクト
  def roop
    @cat = Cat.find(params[:cat_id])
    @records = @cat.records.where(cat_id: params[:cat_id])
    if@records.count == 0
      redirect_to root_path
    end 
  end  
#ログインユーザー自身以外アクセス禁止
  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end

end

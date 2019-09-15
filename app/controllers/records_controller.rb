class RecordsController < ApplicationController
  
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
#======
  def result_view
#猫複数形パラメーター
    @obj ={}
    if params[:records]
      cats_multiple_parameter.each do |id,item|
        @cats={}
        cat = Cat.find id
        if cat.cat_age >1.2
          obj= Base.find_by(data_age: 1.2)
          min_weight = obj.min_weight
          max_weight = obj.max_weight
          if cat.cat_weight < min_weight
            str = "痩せてます"
          elsif  cat.cat_weight >max_weight
            str = "太ってます"
          elsif cat.cat_weight >= min_weight && cat.cat_weight<= max_weight
            str = "標準です"    
          end
        end
        @cats[:id] = cat.id
        @cats[:date] = Date.today
        @cats[:name] = cat.cat_name
        @cats[:weight] = cat.cat_weight
        @cats[:data_weight] = "#{min_weight}~#{max_weight}"
        @cats[:result] = str
        @obj[id]=@cats
      end    
#猫単数パラメーター      
    elsif params[:name]
      @cat = Cat.find(params[:id])
      @date = Date.today
      if @cat.cat_age > 1.2
        obj = Base.find_by(data_age: 1.2)
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
      end     
    end    
  end
#========================================================  
private

#猫単数パラメーター
  def cats_multiple_parameter
    params.permit(records:[:id,:name,:age,:weight])[:records]
  end
#猫単数パラメーター
  def cat_single_parameter
    params.permit(:id,:name,:age,:weight)
  end
  
end

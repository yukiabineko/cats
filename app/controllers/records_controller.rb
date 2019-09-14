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
    @array = set_array
  
  end
  
end

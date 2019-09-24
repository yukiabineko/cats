class HistoriesController < ApplicationController
   require 'net/http'
   require 'uri'
   require 'json'
#検索ページ  
  def show
  
    @data = [] #ハッシュ格納配列
    if request.post?
      yquery = 'https://map.yahooapis.jp/search/local/V1/localSearch?output=json&appid=dj00aiZpPWtSVWR3NDlFcHcwYiZzPWNvbnN1bWVyc2VjcmV0Jng9NTE-&gc='+params[:category].to_s+'&query='+params[:prefectures].to_s
      yquery_enc = URI.encode yquery
      uri = URI.parse(yquery_enc)
      json = Net::HTTP.get(uri)
      
      @hairetu = JSON.parse(json) #配列形式に変換
      
     
      if  @hairetu['Feature'] ==nil || params[:prefectures].blank?
          flash[:danger] = "該当データがないか、入力が不正です。"
          render:show
      else
        @count = @hairetu['Feature'].length
        puts @count
        for i in 0..@count-1
           name = {}
           name[:name] = @hairetu['Feature'][i]['Name']
           name[:area] = @hairetu['Feature'][i]['Property']['Address']
           name[:tel] = @hairetu['Feature'][i]['Property']['Tel1']
           @data << name
        end  
         cate = @hairetu['Feature'][0]['Property']['Genre'][0]['Name']
         
         redirect_to search_result_url(params[:prefectures],cate,params:{data: @data})
      end
 #-----------------------------------------------     
    else
      
    end 
  end
#=検索結果  
  def result
    @user = User.find current_user.id if current_user.present?
    @user.histories.where(save_check: false,save_check: nil).destroy_all
    @area = params[:obj]  
    @data = params[:data]
    @cate = params[:obj2]
    if logged_in?
      @data.each do |dt|
          @user.histories.create(facility_name: dt["name"], prefectures: dt["area"], phone_number: dt["tel"])
      
      end
      @datas = @user.histories.where(save_check: nil)
    end   
  end
#=ユーザー検索保存機能
  def history_save
    history_parameter.each do |id,item|
      history = History.find id
      history.update_attributes(item)
      if item[:save_check] == "0"  
        history.destroy
      end
    end  
    redirect_to history_user_view_url(current_user)
  end
#==検索履歴ページ
  def history_user_view
    @user = User.find(params[:user_id])
    @datas = @user.histories.where(save_check: true)
  
  end
#=履歴削除
 def destroy
   History.find(params[:id]).destroy
   redirect_to history_user_view_url(current_user)
 end
#-履歴全削除
 def all_delete
   @user = User.find current_user.id
   @user.histories.all.destroy_all
   redirect_to history_user_view_url(current_user)
 end
private
#パラメーター
  def history_parameter
    params.permit(histories: [:save_check, :facility_name, :prefectures, :phone_number])[:histories]
  end
end

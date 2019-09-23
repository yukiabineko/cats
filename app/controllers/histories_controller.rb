class HistoriesController < ApplicationController
   require 'net/http'
   require 'uri'
  require 'json'
  
  def show
    @data = [] #ハッシュ格納配列
    if request.post?
      yquery = 'https://map.yahooapis.jp/search/local/V1/localSearch?output=json&appid=dj00aiZpPWtSVWR3NDlFcHcwYiZzPWNvbnN1bWVyc2VjcmV0Jng9NTE-&gc='+params[:category].to_s+'&query='+params[:prefectures].to_s
      yquery_enc = URI.encode yquery
      uri = URI.parse(yquery_enc)
      json = Net::HTTP.get(uri)
      
      @hairetu = JSON.parse(json) #配列形式に変換
      
     
      if  @hairetu['Feature'] ==nil
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
  
  def create
   
  end 
  
  def result
    @area = params[:obj]  
    @data = params[:data]
    @cate = params[:obj2]
  end
end

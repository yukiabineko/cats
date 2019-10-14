module RecordsHelper
     def set_array
         array =[]
         @cats.each do |cat|
             array << cat.cat_name
         end     
         array << "すべての猫ちゃん"
         return array
     end   
#==１歳未満の猫配列
    def cat_ages
      @arr= [["生後0ヶ月",0],["生後1ヵ月",0.1],["生後2ヵ月",0.2],["生後3ヵ月",0.3],["生後4~6ヵ月",0.6],["生後7~8ヵ月",0.7],["生後9~11ヶ月",0.9]] 
    end
#==１歳以上の猫配列    
    def cat_ages2
      @arr= [["生後12ヵ月(1才)",1.0],["生後13ヵ月(1才1ヶ月)",1.1],["1才2ヶ月以上2才未満",1.2]] 
    end
#==ゲスト猫
    def gest_cats
      @arr= [["生後0ヶ月",0],["生後1ヵ月",0.1],["生後2ヵ月",0.2],["生後3ヵ月",0.3],["生後4~6ヵ月",0.6],["生後7~8ヵ月",0.7],["生後9~11ヵ月",0.9],["生後12ヵ月",1.0],["生後13ヵ月",1.1],["1歳2ヵ月以上",1.2]] 
    end 
#最新検査各猫ごと
   def weight_check(cat)
       cat.records.last
   end
#データない場合
     def non_data?     #全猫にてデータがあるかどうか?
       count = 0    #checkは各猫でデータがあるか？一匹でもデータがあればcheckに加算されていく
       @cats.each do |cat|
           unless cat.records.count == 0
              count += 1
           end 
       end
       if count == 0    #すべての猫のレコードチェックして全てぜろだった場合
           return false
       elsif count > 0
         return true
       end       
     end
end

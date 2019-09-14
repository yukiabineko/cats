module RecordsHelper
     def set_array
         array =[]
         @cats.each do |cat|
             array << cat.cat_name
         end     
         array << "すべての猫ちゃん"
         return array
     end         
end

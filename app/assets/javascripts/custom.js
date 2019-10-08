 var obj = document.getElementsByClassName('over_link');
      var num =0;
      colorChange();
    function colorChange(){
     for(var i=0; i<obj.length; i++){
         num +=1;
    if(num %2 == 0){
        obj[i].style.color = "#ff3333";
       
    }
    else{
         obj[i].style.color = "#990000";
         
    }
    setTimeout("colorChange()",50);
     }     
    
}
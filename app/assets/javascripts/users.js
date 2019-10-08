
 $(document).on('change', ':file', function() {
    var input = $(this),
    numFiles = input.get(0).files ? input.get(0).files.length : 1,
    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    input.parent().parent().next(':text').val(label);

    var files = !!this.files ? this.files : [];
    if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support
    if (/^image/.test( files[0].type)){ // only image file
        var reader = new FileReader(); // instance of the FileReader
        reader.readAsDataURL(files[0]); // read the local file
        reader.onloadend = function(){ // set image data as background of div
            input.parent().parent().parent().prev('.imagePreview').css("background-image", "url("+this.result+")");
        }
    }
});
     var obj = document.getElementsByClassName('over_link');
      var num =0;
      colorChange();
    function colorChange(){
     for(var i=0; i<obj.length; i++){
         num +=1
    if(num %2 == 0){
        obj[i].style.color = "#ff3333";
       
    }
    else{
         obj[i].style.color = "#990000";
         
    }
    setTimeout("colorChange()",50);
     }     
    
}
 

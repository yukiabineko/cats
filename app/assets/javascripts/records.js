function selectCat(){
  $.ajax({
      url:"https://0c53d390053d44938f4ea2d409021f09.vfs.cloud9.ap-northeast-1.amazonaws.com/select/"+$("#select").val(),
      dataType:"json",
  }).done(function(data){
      alert(data.name);
  });
}
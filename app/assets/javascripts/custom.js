$(function () {
var mql = window.matchMedia('screen and (max-width: 599px)');
  function checkBreakPoint(mql) {
    if (mql.matches) {
      // スマホ向け（599px以下のとき）
      $('.slideshow.slick-initialized').slick('unslick');
      
    } else {
      // PC向け
     
       $('.slideshow').not('.slick-initialized').slick({
        //スライドさせる
        autoplay:true,
        autoplaySpeed:3000,
        arrows: true,
        dots: true
      });
    }
  }

  // ブレイクポイントの瞬間に発火
  mql.addListener(checkBreakPoint);

  // 初回チェック
  checkBreakPoint(mql);
});
var select= document.getElementById('select');

select.addEventListener('onchange',function(){
    alert("d");
})
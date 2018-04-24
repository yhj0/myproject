
$(document).ready(function(){

//gnb
$('.gnb>li').hover(function(){
  $('.gnb>li').removeClass('active');
   $(this).addClass('active');
   $('.header-sub').stop().slideDown(300);
   $('.gnb>li>ul').stop().slideDown(300);
},function(){
   $(this).removeClass('active');
 $('.header-sub').stop().slideUp(300);
 $('.gnb>li>ul').stop().slideUp(300);
});
$('.gnb>li>a').focus(function(){
  $('.gnb>li').removeClass('active');
   $(this).parent().addClass('active');
   $('.header-sub').show();
   $('.gnb>li>ul').show();
});
$('.gnb>li>ul>li:last-child>a').blur(function(){
  $('.gnb>li').removeClass('active');
   $('.header-sub').hide();
   $('.gnb>li>ul').hide();
});


//add fileBox
var uploadFile = $('.fileBox .uploadBtn');
uploadFile.on('change', function(){
if(window.FileReader){
  var filename = $(this)[0].files[0].name;
} else {
  var filename = $(this).val().split('/').pop().split('\\').pop();
}
$(this).siblings('.fileName').val(filename);
});


});

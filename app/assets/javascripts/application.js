// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .



// 回到顶部
$(document).on('click', '.working', function () {
 alert('功能暂未完成，敬请期待...')
 // return false
}).on('click', '.backtop', function () {
 $('body').animate({'scrollTop': 0}, 500)
}).on('mouseenter', '.support', function () {
 $('.ewm').show().stop().animate({left: '-136px', opacity: 1}, 500)
}).on('mouseleave', '.support', function () {
 $('.ewm').stop().animate({opacity: 0}, 500, function () {
  $(this).css('left', 0).hide()
 })
})

$(window).scroll(function () {
 var $navbar = $('#navbar')
 if ($(this).scrollTop() > 100) {
  $navbar.addClass('black').removeClass('transparent')
 } else {
  $navbar.removeClass('black').addClass('transparent')
 }

 if ($(this).scrollTop() > 500) {
  $('#sidebar').fadeIn()
 } else {
  $('#sidebar').fadeOut()
 }
})


//增减数量
$(document).on('turbolinks:load', function() {
  /*增加数量*/
  $("#quantity-plus").click(function(e) {
    var num = parseInt($("#quantity-input").val()) + 1;
    $("#quantity-minus").removeClass("disabled");
    $("#quantity-input").val(num);
    e.preventDefault();
  });

  /*减少数量*/
  $("#quantity-minus").click(function(e) {
    var num = parseInt($("#quantity-input").val());
    if (num > 1) {
      $("#quantity-input").val(num -= 1);
      $("#quantity-plus").removeClass("disabled");
    }
    if (num <= 1) {
      $("#quantity-minus").addClass("disabled");
    }
    e.preventDefault();
  });
});


// flash通知自动消失
$(document).on('turbolinks:load', function() {

  // 收起通知
  slideUpAlert();

});

// 收起通知信息
function slideUpAlert() {
  // 消息停留2000毫秒（2秒），消失动画时间250毫秒
  $(".alert").delay(1000).slideUp(250, function() {
    $(this).remove();
  });
}

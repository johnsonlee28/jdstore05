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
//= require jquery_ujs

//= require jquery.turbolinks
//= require bootstrap/alert
//= require bootstrap/dropdown
//= require bootstrap-sprockets
//= require social-share-button
//= require masonry/jquery.masonry
//= require_tree .

/* product-preview */
$(document).on('mouseover', '.intro-preview-item', function () {
  var src = $(this).find('img').attr('src')
  $('.intro-bigPic img').attr('src', src)
    $('#thumb-lens').css('background-image', 'url(' + src + ')')
  $(this).addClass('intro-preview-activeItem').siblings().removeClass('intro-preview-activeItem')
  m.attach({
        thumb: '#thumb',
        large: src,
        largeWrapper: 'preview'
  })
})

$('.intro-preview-activeItem').trigger('mouseover')
$(document).on('mouseover', '.magnifier-thumb-wrapper', function (e) {
    $('#preview').css('visibility', 'visible')
})
$(document).on('mouseout', '.magnifier-thumb-wrapper', function (e) {
    $('#preview').css('visibility', 'hidden')
})


// 详情菜单栏切换
$(document).on('click', '.productDetail-tabList-tab', function () {
  $(this).addClass('productDetail-tabList-activeTab').siblings().removeClass('productDetail-tabList-activeTab')
  $('.productDetail-content').eq($(this).index()).show().siblings().hide()
})


/* scroll effect  */
(function ($) {
  $(document).ready(function(){
    $('.index').hide();
    $(function () {
        $(window).scroll(function () {

            if ($(this).scrollTop() > 800) {
                $('.index').fadeIn();
            } else {
                $('.index').fadeOut();
            }
        });
    });

    $(function () {
        $(window).scroll(function () {
            if ($(this).scrollTop() > 100) {
                $('.animated').fadeOut();
            } else {
                $('.animated').fadeIn();
            }
        });
    });

});
  }(jQuery));

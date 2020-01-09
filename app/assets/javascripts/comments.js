$(document).on('turbolinks:load',function() {
  load_message();
  click_button_reply();
  show_reply();
})

function load_message(){
  $("#comments-link").click(function() {
    $(".form-comments").fadeToggle();
    $(".content-Post").focus();
  });
}

function click_button_reply(){
  $(".button-reply").click(function() {
    var id = $(this).attr("id");
    $("#reply-"+id).fadeToggle();
    $(".content-Comment").focus();
  });
}

function show_reply(){
  $(".show-reply").click(function() {
    var id = $(this).attr("id");
    var s = id.substring(id.lastIndexOf("-")+1, id.legth);
    $(this).hide();
    $("#sub-"+s).show();
  });
}

$(document).on('turbolinks:load',function(){
  setTimeout(function(){
    $('.message-content').fadeOut();
  }, 3000);

  $(function () {
    $('#datetimepicker').datetimepicker({
      showClose: true,
      minDate: moment(),
      format: 'YYYY-MM-DD HH:mm',
      enabledHours: [8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
      defaultDate: moment()
    });
  });
})

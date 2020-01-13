$(document).on('turbolinks:load',function(){
  $(".check_all").click(function() {
    $(".checkSingle").prop("checked", !this.checked);
    $(".checkSingle").click();
  });

  $(".checkSingle").click(function(){
    if ($(this).is(":checked")) {
      var isAllChecked = true;
      $(".checkSingle").each(function() {
        if(!this.checked)
          isAllChecked = false;
      })
      $(".check_all").prop("checked", isAllChecked);
    }else {
      $(".check_all").prop("checked", false);
    }
  });
})

function search_by_email() {
  var $filter, $td;
  $filter = $("#myInput").val().toUpperCase();
  $("#myTable > tbody > tr").each(function() {
    $td = $(this).find("td:nth-child(2)");
    if ($td) {
      if ($td.text().toUpperCase().indexOf($filter) > -1) {
        $(this).show();
      }else {
        $(this).hide();
      }
    }
  });
}

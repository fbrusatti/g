$(document).ready(function(){
  $('.appointment_date_time_picker').datetimepicker();
});

$(document).ready(function() {
  $("a.appointment-save").click(function() {
    $("#new_appointment, [id^=edit_appointment_]").submit();
  });
})

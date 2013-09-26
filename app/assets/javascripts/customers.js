$(document).ready(function() {
  $("a.customer-save").click( function() {
    $("#new_customer, [id^=edit_customer_]").submit();
  });

  $('#customer-dob').datetimepicker({
    maskInput: true,
    pickDate: true,
    pickTime: false,
    pick12HourFormat: false,
    pickSeconds: false,
    startDate: 1910,
    endDate:  Date.today
  });
})

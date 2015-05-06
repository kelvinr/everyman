$(function() {
  $("#start").datetimepicker({
    format: "MMMM D YYYY",
    extraFormats: ["MMMM D YY"]
  }),
  $("#end").datetimepicker({
    format: "MMMM D YYYY",
    extraFormats: ["MMMM D YY"]
  }),
  $("#daily").datetimepicker({
    format: " h : mm"
  }),
  $("#core").datetimepicker({
    format: " h : mm"
  }),
  $("#nap-count").datetimepicker({
    format: " m"
  }),
  $("#nap-duration").datetimepicker({
    format: " h : mm"
  });
});

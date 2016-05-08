$(function(){
  $.each($(".project_time_usage"), function(index, item) {
    var ctx = item.getContext("2d");
    var project_id = $(item).data().id;

    $.ajax("/projects/" + project_id + "/time_usage").success(function(data) {
      var options = {
        scales: {
          yAxes: [{
            stacked: true
          }]
        }
      }

      Chart.Line(ctx, {
        data: data,
        options: options
      });
    })
  })
})

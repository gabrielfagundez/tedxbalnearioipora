$(function(){
  $.each($(".project_progress_velocity"), function(index, item) {
    var ctx = item.getContext("2d");
    var project_id = $(item).data().id;

    $.ajax("/api/projects/" + project_id + "/velocity_progress").success(function(data) {
      var options = {
        legend: {
          display: false
        },
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        }
      };

      Chart.Line(ctx, {
        data: data,
        options: options
      });
    })
  })
})

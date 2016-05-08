$(function(){
  $.each($(".project_velocity"), function(index, item) {
    var ctx = item.getContext("2d");
    var project_id = $(item).data().id;

    $.ajax("/projects/" + project_id + "/velocity").success(function(data) {
      var options = {
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

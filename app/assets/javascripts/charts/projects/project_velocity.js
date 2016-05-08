$(function(){
  $.each($(".project_velocity"), function(index, item) {
    var ctx = item.getContext("2d");
    var project_id = $(item).data().id;

    $.ajax("/projects/" + project_id + "/velocity").success(function(data) {
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

      $(item).closest('.box').find('.js-min').html(data.metadata.min);
      $(item).closest('.box').find('.js-avg').html(data.metadata.avg);
      $(item).closest('.box').find('.js-max').html(data.metadata.max);

      Chart.Line(ctx, {
        data: data,
        options: options
      });
    })
  })
})

$(function(){
  var chart;

  function createChart(project_id, ctx, months) {
    $.ajax("/api/projects/" + project_id + "/velocity_progress?months=" + months).success(function(data) {
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

      chart = Chart.Line(ctx, {
        data: data,
        options: options
      });
    })
  }

  $.each($(".project_progress_velocity"), function(index, item) {
    var ctx = item.getContext("2d");
    var project_id = $(item).data().id;

    createChart(project_id, ctx, 3);

    $(item).closest(".js-parent").find('.js-1-months').on('click', function() {
      $(item).closest(".js-parent").find('.is-active').removeClass('is-active');
      $(item).closest(".js-parent").find('.js-1-months').addClass('is-active');
      chart.destroy();
      createChart(project_id, ctx, 1)
    })

    $(item).closest(".js-parent").find('.js-3-months').on('click', function() {
      $(item).closest(".js-parent").find('.is-active').removeClass('is-active');
      $(item).closest(".js-parent").find('.js-3-months').addClass('is-active');
      chart.destroy();
      createChart(project_id, ctx, 3)
    })

    $(item).closest(".js-parent").find('.js-6-months').on('click', function() {
      $(item).closest(".js-parent").find('.is-active').removeClass('is-active');
      $(item).closest(".js-parent").find('.js-6-months').addClass('is-active');
      chart.destroy();
      createChart(project_id, ctx, 6)
    })
  })
})

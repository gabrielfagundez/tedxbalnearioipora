$(function(){
  $.each($(".project_time_usage"), function(index, item) {
    var ctx = item.getContext("2d");
    var project_id = $(item).data().id;

    $.ajax("/projects/" + project_id + "/time_usage").success(function(data) {
      var options = {
        legend: {
          display: false
        },
        scales: {
          yAxes: [{
            stacked: true
          }]
        }
      }

      $(item).closest('.box').find('.js-max-val-1').html(data.metadata.max1.value);
      $(item).closest('.box').find('.js-max-label-1').html(data.metadata.max1.label);
      $(item).closest('.box').find('.js-max-val-2').html(data.metadata.max2.value);
      $(item).closest('.box').find('.js-max-label-2').html(data.metadata.max2.label);
      $(item).closest('.box').find('.js-max-val-3').html(data.metadata.max3.value);
      $(item).closest('.box').find('.js-max-label-3').html(data.metadata.max3.label);

      Chart.Line(ctx, {
        data: data,
        options: options
      });
    })
  })
})

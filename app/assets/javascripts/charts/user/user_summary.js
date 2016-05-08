$(function(){
  $.each($(".user_summary"), function(index, item) {
    var ctx = item.getContext("2d");
    var user_id = $(item).data().id;

    $.ajax("/users/" + user_id + "/summary").success(function(data) {
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

      Chart.Line(ctx, {
        data: data,
        options: options
      });
    })
  })
})

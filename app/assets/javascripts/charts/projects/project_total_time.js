$(function(){
  $.each($(".project_total_time"), function(index, item) {
    var ctx = item.getContext("2d");
    var project_id = $(item).data().id;

    $.ajax("/api/projects/" + project_id + "/total_time").success(function(data) {
      var options = {
        legend: {
          display: false
        }
      };

      new Chart(ctx, {
        type: 'bar',
        data: data,
        options: options
      });
    })
  })
})

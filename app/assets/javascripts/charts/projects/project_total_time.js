$(function(){
  $.each($(".project_total_time"), function(index, item) {
    var ctx = item.getContext("2d");
    var project_id = $(item).data().id;

    $.ajax("/projects/" + project_id + "/total_time").success(function(data) {
      var options = {};

      new Chart(ctx, {
        type: 'bar',
        data: data,
        options: options
      });
    })
  })
})

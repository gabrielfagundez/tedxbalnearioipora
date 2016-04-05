$(function(){
  $.each($(".project_historical"), function(index, item) {
    var ctx = item.getContext("2d");
    var project_id = $(item).data().id;

    $.ajax("/projects/" + project_id + "/historical").success(function(data) {
      new Chart(ctx).Pie(data, {
        responsive: true
      });
    })
  })
})

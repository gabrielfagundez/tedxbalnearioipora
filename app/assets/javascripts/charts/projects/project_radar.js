$(function(){
  $.each($(".project_radar"), function(index, item) {
    var ctx = item.getContext("2d");
    var project_id = $(item).data().id;

    $.ajax("/projects/" + project_id + "/radar").success(function(data) {
      var options = {};

      new Chart(ctx, {
        type: 'radar',
        data: data,
        options: options
      });
    })
  })
})

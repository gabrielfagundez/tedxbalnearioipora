$(function(){
  $.each($(".project_summary"), function(index, item) {
    var ctx = item.getContext("2d");
    var project_id = $(item).data().id;

    $.ajax("/projects/" + project_id + "/summary").success(function(data) {
      new Chart(ctx).Line(data, {
        responsive: true
      });
    })
  })
})

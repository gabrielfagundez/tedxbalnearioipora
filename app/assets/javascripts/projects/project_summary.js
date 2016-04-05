$(function(){
  if(document.getElementById("project_summary") != undefined) {
    var ctx = document.getElementById("project_summary").getContext("2d");
    var project_id = $('#project_summary').data().id;

    $.ajax("/projects/" + project_id + "/summary").success(function(data) {
      new Chart(ctx).Line(data, {
        responsive: true
      });
    })
  }
})

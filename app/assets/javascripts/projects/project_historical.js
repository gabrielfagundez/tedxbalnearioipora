$(function(){
  if(document.getElementById("project_historical") != undefined) {
    var ctx = document.getElementById("project_historical").getContext("2d");
    var project_id = $('#project_historical').data().id;

    $.ajax("/projects/" + project_id + "/historical").success(function(data) {
      new Chart(ctx).Pie(data, {
        responsive: true
      });
    })
  }
})

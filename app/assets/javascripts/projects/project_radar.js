$(function(){
  if(document.getElementById("project_radar") != undefined) {
    var ctx = document.getElementById("project_radar").getContext("2d");
    var project_id = $('#content').data().id;

    $.ajax("/projects/" + project_id + "/radar").success(function(data) {
      new Chart(ctx).Radar(data, {
        responsive: true
      });
    })
  }
})

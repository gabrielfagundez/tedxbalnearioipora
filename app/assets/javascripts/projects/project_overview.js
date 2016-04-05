$(function(){
  if(document.getElementById("project_overview") != undefined) {
    var ctx = document.getElementById("project_overview").getContext("2d");
    var project_id = $('#content').data().id;

    $.ajax("/projects/" + project_id + "/overview").success(function(data) {
      new Chart(ctx).Bar(data, {
        responsive: true
      });
    })
  }
})

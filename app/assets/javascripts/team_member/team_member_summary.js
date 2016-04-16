$(function(){
  $.each($(".team_member_summary"), function(index, item) {
    var ctx = item.getContext("2d");
    var team_member_id = $(item).data().id;

    $.ajax("/team_members/" + team_member_id + "/summary").success(function(data) {
      new Chart(ctx).Line(data, {
        responsive: true
      });
    })
  })
})

app.controller('ReportsController', ['$scope', '$interval', 'TimeEntry', 'Project', 'TimeCategory', 'User', function($scope, $interval, TimeEntry, Project, TimeCategory, User) {

  var interval;
  var dateBlock = null;
  var currentDurations = {};
  var processedIds = {};
  var projectSelect, catSelect;

  var keys = {
    enter: 13,
    at: 64,
    exc: 33
  }

  $scope.entryData = {
    currentTimeEntryId: null,
    description: "",
    project: {},
    category: {},
    billable: {},
    currentTime: null
  }

  $scope.timeEntries = [];
  TimeEntry.getAll().success(function(data) {
    $scope.timeEntries = data;
  });

  $scope.projects = {};
  Project.getAll().success(function(data) {
    $.each(data, function(index, project) {
      var clientName = project.client_name;

      if($scope.projects[clientName] == null) {
        $scope.projects[clientName] = { text: clientName, children: [] };
      }
      $scope.projects[clientName].children.push({ id: project.id, text: project.name, color: project.color })
    });

    var optHTML = "";
    $.each($scope.projects, function(id, client) {
      optHTML += "<optgroup label='" + client.text + "'>";
      $.each(client.children, function(id, project) {
        optHTML += "<option value='" + project.id + "'>" + project.text + "</option>";
      });
      optHTML += "</optgroup>"
    })
    $('.js-proj-select').html(optHTML);
  });

  User.getAll().success(function(data) {
    var optHTML = "";
    $.each(data, function(index, user) {
      optHTML += "<option value='" + user.id + "'>" + user.first_name + ' ' + user.last_name + "</option>";
    });

    $('.js-user-select').html(optHTML);
  });

  TimeCategory.getAll().success(function(data) {
    var optHTML = "";
    $.each(data, function(index, tag) {
      optHTML += "<option value='" + tag.id + "'>" + tag.name + "</option>";
    });

    $('.js-tag-select').html(optHTML);
  });

}]);

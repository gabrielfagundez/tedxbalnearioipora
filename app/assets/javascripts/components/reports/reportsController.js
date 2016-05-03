app.controller('ReportsController', ['$scope', 'TimeEntry', function($scope, TimeEntry) {

  var searchEntities = {
    users: '.js-user-select',
    projects: '.js-proj-select',
    time_categories: '.js-time-category-select',
    description: '.js-description'
  }

  $scope.timeEntries = [];
  TimeEntry.getAll().success(function(data) {
    $scope.timeEntries = data;
  });

  $scope.search = function() {
    var searchParameters = {
      description: $(searchEntities.description).val()
    }

    if($(searchEntities.users).val() != null) {
      searchParameters.users = $(searchEntities.users).val().join(',')
    }

    if($(searchEntities.projects).val() != null) {
      searchParameters.projects = $(searchEntities.projects).val().join(',')
    }

    if($(searchEntities.time_categories).val() != null) {
      searchParameters.time_categories = $(searchEntities.time_categories).val().join(',')
    }

    TimeEntry.getAll(searchParameters).success(function(data) {
      $scope.timeEntries = data;
    });
  }

}]);

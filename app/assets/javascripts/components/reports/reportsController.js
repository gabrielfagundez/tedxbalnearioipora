app.controller('ReportsController', ['$scope', '$interval', 'TimeEntry', 'Project', 'TimeCategory', 'User', function($scope, $interval, TimeEntry, Project, TimeCategory, User) {

  $scope.timeEntries = [];
  TimeEntry.getAll().success(function(data) {
    $scope.timeEntries = data;
  });

}]);

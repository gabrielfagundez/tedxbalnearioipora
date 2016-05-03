app.controller('ReportsController', ['$scope', 'TimeEntry', function($scope, TimeEntry) {

  var currentDurations = {};
  var processedIds = {};
  var dateBlock = null;

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

  $scope.newDateBlock = function(date, index) {
    var oldDateBlock = dateBlock;
    dateBlock = date;
    return oldDateBlock != dateBlock || index == 0;
  }

  $scope.empty = function(text) {
    return text.length == 0;
  }

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

  $scope.formatFromTo = function(from, to) {
    return from + " - " + to;
  }

  $scope.formatDuration = function(id, date, duration) {
    if(currentDurations[date] == null) {
      if(processedIds[id] == null) {
        processedIds[id] = true;
        currentDurations[date] = duration;
      }
    } else {
      if(processedIds[id] == null) {
        processedIds[id] = true;
        currentDurations[date] += duration;
      }
    }

    return formatTime(duration);
  }

  // Private

  var formatTime = function(secs) {
    if(secs <= 60) {
      return secs + " sec";
    } else {
      var hs = String(Math.round(secs / (60*60)));
      if(hs < 10) {
        hs = "0" + hs;
      }

      var mn = String(Math.round(secs / (60)) % 60);
      if(mn < 10) {
        mn = "0" + mn;
      }

      var sc = String(secs % 60);
      if(sc < 10) {
        sc = "0" + sc;
      }

      return hs + ":" + mn + ":" + sc;
    }
  }

}]);

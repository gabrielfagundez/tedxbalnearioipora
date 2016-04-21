app.controller('TimeEntryController', ['$scope', '$interval', 'TimeEntry', function($scope, $interval, TimeEntry) {

  var interval;
  var currentTimeEntryId;
  var dateBlock = null;
  var currentDurations = {};
  var processedIds = {};

  $scope.entryData = {
    'project': null,
    'category': null,
    'billable': null,
    'currentTime': null
  }

  $scope.timeEntries = [];
  TimeEntry.getAll().success(function(data) {
    $scope.timeEntries = data;
  })

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

  $scope.currentDuration = function(id, date, duration) {
    return formatTime(currentDurations[date]);
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

  $scope.newDateBlock = function(date) {
    oldDateBlock = dateBlock;
    dateBlock = date;
    return oldDateBlock != dateBlock;
  }

  $scope.formatFromTo = function(from, to) {
    return from + " - " + to;
  }

  $scope.inProgress = function() {
    return $scope.entryData.currentTime != null;
  }

  $scope.startTimer = function() {
    $scope.entryData.currentTime = 0;
    $('.js-time').val(formatTime($scope.entryData['currentTime']))

    interval = $interval(function() {
      $scope.entryData.currentTime += 1;
      $('.js-time').val(formatTime($scope.entryData['currentTime']))
    }, 1000)

    TimeEntry.create().success(function(data) {
      currentTimeEntryId = data.id;
    });
  }

  $scope.stopTimer = function() {
    $scope.entryData.currentTime = null;
    $('.js-time').val(null);
    $interval.cancel(interval);

    var timeEntryData = {
      project_id: $scope.entryData.project.id,
      time_category_id: $scope.entryData.category.id,
      billable: $scope.entryData.billable.id,
      description: $('.js-description').val()
    }

    $('.js-description').val("")

    TimeEntry.close(currentTimeEntryId, timeEntryData);
    TimeEntry.getAll().success(function(data) {
      $scope.timeEntries = data;
    })
  }

  $scope.entryData = function(entityCategory) {
    if($scope.entryData[entityCategory] != null) {
      return $scope.entryData[entityCategory].name
    } else {
      return entityCategory
    }
  }

  $scope.selectEntity = function(entity, entityData, modalId) {
    $scope.entryData[entity] = {
      name: entityData.name,
      id: entityData.id
    }

    if(modalId != null) {
      $(modalId).modal('toggle');
    }
  }

}]);

app.controller('TimeEntryController', ['$scope', '$interval', 'TimeEntry', 'Project', 'TimeCategory', function($scope, $interval, TimeEntry, Project, TimeCategory) {

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
        optHTML += "<option value='" + project.id + "-" + project.color + "'>" + project.text + " - " + client.text + "</option>";
      });
      optHTML += "</optgroup>"
    })
    $('.js-proj-select2').html(optHTML);
    projectSelect = $('.js-proj-select2').select2();
    projectSelect.on("select2:select", onProjectSelect);
    onProjectSelect(false);

    getLastTimeEntry();
  });

  var onProjectSelect = function (trigger) {
    attrs = projectSelect.val().split('-');
    $scope.entryData.project = { id: attrs[0] };
    $('.js-project .js-selected').attr('style', 'background-color: ' + attrs[1] + ' !important');

    if(trigger) {
      var timeEntryData = { project_id: $scope.entryData.project.id };
      TimeEntry.update($scope.entryData.currentTimeEntryId, timeEntryData);
    }
  }

  $scope.categories = {};
  TimeCategory.getAll().success(function(data) {
    var optHTML = "<optgroup label='Time Tracking Categories'>";;
    $.each(data, function(index, cat) {
      optHTML += "<option value='" + cat.id + "'>" + cat.name + "</option>";
    });
    optHTML += "</optgroup>";

    $('.js-cat-select2').html(optHTML);
    catSelect = $('.js-cat-select2').select2();
    catSelect.on("select2:select", onCatSelect);
    onCatSelect(false);
  });

  var onCatSelect = function (trigger) {
    attrs = catSelect.val().split('-');
    $scope.entryData.category = { id: attrs[0] };

    if(trigger) {
      var timeEntryData = { time_category_id: $scope.entryData.category.id };
      TimeEntry.update($scope.entryData.currentTimeEntryId, timeEntryData);
    }
  }

  var getLastTimeEntry = function() {
    TimeEntry.lastOpen().success(function(data) {
      if(data != null) {
        $scope.entryData.currentTime = data.duration;
        $scope.entryData.currentTimeEntryId = data.id;
        $scope.entryData.description = data.description;
        setCurrentTime();
        setDescription();

        projectSelect.val(data.project.id + "-" + data.project.color).trigger("change");
        onProjectSelect(true);

        catSelect.val(data.tag.id).trigger("change");;
        onCatSelect(true);

        $scope.entryData.billable = { id: data.billable.id, name: data.billable.name };
      }
    });
  }

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

  var setCurrentTime = function() {
    $('.js-time').val(formatTime($scope.entryData['currentTime']))
    interval = $interval(function() {
      $scope.entryData.currentTime += 1;
      $('.js-time').val(formatTime($scope.entryData['currentTime']))
    }, 1000)
  }

  var setDescription = function() {
    $('.js-description').val($scope.entryData.description)
  }

  $scope.keyPressed = function(event) {
    if(event.keyCode == keys.enter) {
      if(!$scope.inProgress()) {
        $scope.startTimer();
      }
    } else if(event.keyCode == keys.at) {
    } else if(event.keyCode == keys.exc) {
    }
  }

  $scope.currentDuration = function(id, date, duration) {
    return formatTime(currentDurations[date]);
  }

  $scope.empty = function(text) {
    return text.length == 0;
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

  $scope.newDateBlock = function(date, index) {
    var oldDateBlock = dateBlock;
    dateBlock = date;
    return oldDateBlock != dateBlock || index == 0;
  }

  $scope.formatFromTo = function(from, to) {
    return from + " - " + to;
  }

  $scope.inProgress = function() {
    return $scope.entryData.currentTime != null;
  }

  $scope.startTimer = function() {
    $scope.entryData.currentTime = 0;
    setCurrentTime()

    var timeEntryData = {};
    if($scope.entryData.project != null) {
      timeEntryData.project_id = $scope.entryData.project.id;
    }
    if($scope.entryData.category != null) {
      timeEntryData.time_category_id = $scope.entryData.category.id;
    }
    if($scope.entryData.billable != null) {
      timeEntryData.billable = $scope.entryData.billable.id;
    }
    timeEntryData.description = $('.js-description').val();

    TimeEntry.create(timeEntryData).success(function(data) {
      $scope.entryData.currentTimeEntryId = data.id;
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

    TimeEntry.close($scope.entryData.currentTimeEntryId, timeEntryData);
    TimeEntry.getAll().success(function(data) {
      $scope.timeEntries = data;
    })
  }

  $scope.editEntry = function(id) {
    $('#edit_modal').modal('toggle');
  }

  $scope.addTimeEntry = function() {
    $('#edit_modal').modal('toggle');
  }

  $scope.continueEntry = function(id) {
    TimeEntry.continue(id).success(function() {
      getLastTimeEntry();
    });

  }

  $scope.deleteEntry = function(id) {
    dialog = confirm("Are you sure you want to delete this entry?");
    if(dialog) {
      TimeEntry.delete(id);
      TimeEntry.getAll().success(function(data) {
        $scope.timeEntries = data;
      });
    }
  }

}]);

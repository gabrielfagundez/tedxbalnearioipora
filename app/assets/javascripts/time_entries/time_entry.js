Timer = (function(){
  var startButton;
  var stopButton;
  var projectItem;
  var categoryItem;
  var billableItem;
  var timerValue = 0;
  var timerValueDiv;
  var timerInterval;
  var project;
  var category;
  var billable;

  var formatTimerValue = function(val) {
    if(val <= 60) {
      return String(val) + " secs"
    } else if (val > 60 && val <= 3600) {
      return String(Math.round(val / 60)) + " mins " + String(val % 60) + " secs"
    }
  }

  var handleCategorySelection = function(event) {
    category = {
      id: $(event.target).data().categoryId,
      name: $(event.target).data().categoryName
    }
    $('.js-category').html(category.name);
    $('#category_modal').modal('toggle');
  }

  var handleBillableSelection = function(event) {
    billable = {
      id: $(event.target).data().billableId,
      name: $(event.target).data().billableName
    }
    $('.js-billable').html(billable.name);
    $('#billable_modal').modal('toggle');

    console.debug(billable)
  }

  var handleProjectSelection = function(event) {
    project = {
      id: $(event.target).data().projectId,
      name: $(event.target).data().projectName
    }
    $('.js-project').html(project.name);
    $('#project_modal').modal('toggle');
  }

  var handleStartClick = function() {
    startButton.hide();
    stopButton.show();
    timerValueDiv.val(formatTimerValue(timerValue));

    timerInterval = setInterval(function () {
      timerValue += 1;
      timerValueDiv.val(formatTimerValue(timerValue));
    }, 1000);
  }

  var handleStopClick = function() {
    stopButton.hide();
    startButton.show();

    timerValueDiv.val(null);
    clearInterval(timerInterval);
  }

  return {
    init: function() {
      startButton = $('.js-timer__start');
      stopButton = $('.js-timer__stop');
      projectItem = $('.js-select-project');
      categoryItem = $('.js-select-category');
      billableItem = $('.js-select-billable');
      timerValueDiv = $('.js-timer__value');

      startButton.on('click', handleStartClick);
      stopButton.on('click', handleStopClick);
      projectItem.on('click', handleProjectSelection);
      categoryItem.on('click', handleCategorySelection);
      billableItem.on('click', handleBillableSelection);
    }
  }

})();

$(function() {
  if ($('.js-timer').length){
    Timer.init();
  }
});

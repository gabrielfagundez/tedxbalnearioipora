app.directive('projectMultipleSelector', ['TemplatesHelper', function(TemplatesHelper) {
  return {
    templateUrl: TemplatesHelper.projectMultipleSelector(),
    controller: 'ProjectMultipleSelectorController'
  };
}]);

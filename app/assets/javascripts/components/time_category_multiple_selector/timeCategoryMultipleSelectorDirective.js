app.directive('timeCategoryMultipleSelector', ['TemplatesHelper', function(TemplatesHelper) {
  return {
    templateUrl: TemplatesHelper.timeCategoryMultipleSelector(),
    controller: 'TimeCategoryMultipleSelectorController'
  };
}]);

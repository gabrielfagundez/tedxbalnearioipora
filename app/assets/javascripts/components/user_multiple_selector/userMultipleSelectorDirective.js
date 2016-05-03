app.directive('userMultipleSelector', ['TemplatesHelper', function(TemplatesHelper) {
  return {
    templateUrl: TemplatesHelper.userMultipleSelector(),
    controller: 'UserMultipleSelectorController'
  };
}]);

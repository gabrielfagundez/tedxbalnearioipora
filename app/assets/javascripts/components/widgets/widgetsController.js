app.controller('WidgetsController', ['$scope', 'Widget', function($scope, Widget) {

  $scope.removeWidget = function(id) {
    Widget.destroy(id);
  };

}]);

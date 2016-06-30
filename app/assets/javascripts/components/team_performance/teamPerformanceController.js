app.controller('TeamPerformanceController', ['$scope', function($scope) {

  $scope.triggerModal = function() {
    $('#velocity-periods-modal').modal('toggle');
  }

}]);

app.controller('ProjectShowController', ['$scope', function($scope) {

  $scope.triggerMisionModal = function() {
    $('#project-mision-modal').modal('toggle');
  }

  $scope.triggerVisionModal = function() {
    $('#project-vision-modal').modal('toggle');
  }

}]);

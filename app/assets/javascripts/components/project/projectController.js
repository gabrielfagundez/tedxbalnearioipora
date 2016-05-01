app.controller('ProjectController', ['$scope', 'Project', function($scope, Project) {

  $scope.toggleFavorite = function(event, id) {
    event.preventDefault();
    Project.toggleFav(id);
    
    $(event.target).toggleClass('fa-star-o');
    $(event.target).toggleClass('fa-star');
  }

}]);

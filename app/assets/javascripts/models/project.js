app.factory('Project', ['$http', function($http) {

  var service = {};

  service.getAll = function() {
    return $http.get('/api/projects/');
  };

  return service;
}]);

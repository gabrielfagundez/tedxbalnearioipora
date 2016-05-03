app.factory('User', ['$http', function($http) {

  var service = {};

  service.getAll = function() {
    return $http.get('/api/users/');
  };

  return service;
}]);

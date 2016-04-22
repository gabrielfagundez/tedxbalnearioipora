app.factory('TimeCategory', ['$http', function($http) {

  var service = {};

  service.getAll = function() {
    return $http.get('/api/time_categories/');
  };

  return service;
}]);

app.factory('Widget', ['$http', function($http) {

  var service = {};

  service.destroy = function(id) {
    return $http.delete('/api/widgets/' + id);
  };

  return service;
}]);

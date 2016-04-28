app.factory('Project', ['$http', function($http) {

  var service = {};

  service.getAll = function() {
    return $http.get('/api/projects/');
  };

  service.toggleFav = function(id) {
    return $http.post('/api/projects/' + id + '/toggle_fav');
  };

  return service;
}]);

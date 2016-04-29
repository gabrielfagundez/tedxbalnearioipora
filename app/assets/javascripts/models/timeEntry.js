app.factory('TimeEntry', ['$http', function($http) {

  var service = {};

  service.getLast = function() {
    return $http.get('/api/time_entries/last');
  };

  service.getAll = function() {
    return $http.get('/api/time_entries/');
  };

  service.lastOpen = function() {
    return $http.get('/api/time_entries/last_open');
  };

  service.create = function(timeEntryData) {
    return $http.post('/api/time_entries/', { time_entry_data: timeEntryData })
  };

  service.update = function(id, timeEntryData) {
    return $http.put('/api/time_entries/' + id, { time_entry_data: timeEntryData })
  };

  service.close = function(id, timeEntryData) {
    return $http.put('/api/time_entries/' + id + '/close', { time_entry_data: timeEntryData })
  };

  service.delete = function(id) {
    return $http.delete('/api/time_entries/' + id)
  };

  service.continue = function(id) {
    return $http.post('/api/time_entries/' + id + '/continue')
  };

  return service;
}]);

app.controller('UserMultipleSelectorController', ['$scope', 'User', function($scope, User) {

  User.getAll().success(function(data) {
    var optHTML = "";
    $.each(data, function(index, user) {
      optHTML += "<option value='" + user.id + "'>" + user.first_name + ' ' + user.last_name + "</option>";
    });

    $('.js-user-select').html(optHTML);
  });

}]);

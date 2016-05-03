app.controller('TimeCategoryMultipleSelectorController', ['$scope', 'TimeCategory', function($scope, TimeCategory) {

  TimeCategory.getAll().success(function(data) {
    var optHTML = "";
    $.each(data, function(index, tag) {
      optHTML += "<option value='" + tag.id + "'>" + tag.name + "</option>";
    });

    $('.js-time-category-select').html(optHTML);
  });

}]);

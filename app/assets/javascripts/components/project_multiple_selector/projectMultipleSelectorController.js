app.controller('ProjectMultipleSelectorController', ['$scope', 'Project', function($scope, Project) {

  $scope.projects = {};
  Project.getAll().success(function(data) {
    $.each(data, function(index, project) {
      var clientName = project.client_name;

      if($scope.projects[clientName] == null) {
        $scope.projects[clientName] = { text: clientName, children: [] };
      }
      $scope.projects[clientName].children.push({ id: project.id, text: project.name, color: project.color })
    });

    var optHTML = "";
    $.each($scope.projects, function(id, client) {
      optHTML += "<optgroup label='" + client.text + "'>";
      $.each(client.children, function(id, project) {
        optHTML += "<option value='" + project.id + "'>" + project.text + "</option>";
      });
      optHTML += "</optgroup>"
    })
    $('.js-proj-select').html(optHTML);
  });

}]);

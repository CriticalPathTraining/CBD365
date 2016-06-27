'use strict';

var app = angular.module('UnifiedApiSpa');

app.controller('messagesController', ['$scope', 'unifiedApiService', messagesController]);

function messagesController($scope, unifiedApiService) {

  unifiedApiService.getMessages()
    .success(function (data) {
      $scope.messages = data.value;
      $scope.actions = {};
      $scope.actions.deleteMessage = function (objectId) {
         unifiedApiService.deleteMessage(objectId).then(
          function () {
            alert('got here');

            $scope.$apply();
          },
          function () {
            alert("Error deleting user");
          });
      };

    })
    .error(function(data, status, headers, config) { alert("Error getting users"); });
}
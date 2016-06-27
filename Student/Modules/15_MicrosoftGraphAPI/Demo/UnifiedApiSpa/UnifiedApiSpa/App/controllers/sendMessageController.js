'use strict';

var app = angular.module('UnifiedApiSpa');

app.controller('sendMessageController', ['$scope', '$location', 'unifiedApiService', 'adalAuthenticationService', sendMessageController]);

function sendMessageController($scope, $location, unifiedApiService, adalService) {

  var upnCurrentUser =  adalService.userInfo.userName;

  $scope.message = {
    To: upnCurrentUser,
    Subject: "Test Message",
    Body: "hey baby baby baby"
  };


  $scope.actions = {
    sendMessage: function () {
      unifiedApiService.sendMessage($scope.message)
        .success(function (data) {
          alert('message sent');
          $location.path("/messages");
        })
        .error(function (data, status, headers, config) {
          alert("Error sending message");
        });
    }
  }

}
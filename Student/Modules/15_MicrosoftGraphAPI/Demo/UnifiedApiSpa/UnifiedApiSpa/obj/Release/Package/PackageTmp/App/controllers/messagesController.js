'use strict';

var app = angular.module('UnifiedApiSpa');

app.controller('messagesController', ['$scope', 'unifiedApiService', messagesController]);

function messagesController($scope, unifiedApiService) {

  unifiedApiService.getMessages()
    .success(function (data) { $scope.messages = data.value; })
    .error(function(data, status, headers, config) { alert("Error getting users"); });
}
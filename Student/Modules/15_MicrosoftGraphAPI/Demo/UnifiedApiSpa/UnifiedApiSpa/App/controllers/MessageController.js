'use strict';

var app = angular.module('UnifiedApiSpa');

app.controller('messageController', ['$scope', '$sce', '$routeParams', 'unifiedApiService', messageController]);

function messageController($scope, $sce, $routeParams, unifiedApiService) {

  var objectId = $routeParams.id;

  unifiedApiService.getMessage(objectId)
    .success(function (data) {
      $scope.message = data;      
      $scope.messageHTML = $sce.trustAsHtml(data.Body.Content);
  }).
  error(function (data, status, headers, config) {
    alert("Error getting message");
  });


}
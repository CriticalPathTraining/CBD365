'use strict';

var app = angular.module('UnifiedApiSpa');

app.controller('groupsController', ['$scope', 'unifiedApiService', groupsController]);

function groupsController($scope, unifiedApiService) {

  unifiedApiService.getGroups().success(function (data) {
    $scope.groups = data.value;
  }).
  error(function (data, status, headers, config) {
    alert("Error getting groups");
  });


}
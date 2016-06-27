'use strict';

var app = angular.module('UnifiedApiSpa');

app.controller('filesController', ['$scope', 'unifiedApiService', filesController]);

function filesController($scope, unifiedApiService) {

  unifiedApiService.getFiles().success(function (data) {
    $scope.files = data.value;
  }).
  error(function(data, status, headers, config) {
    alert("Error getting files");
  });


}
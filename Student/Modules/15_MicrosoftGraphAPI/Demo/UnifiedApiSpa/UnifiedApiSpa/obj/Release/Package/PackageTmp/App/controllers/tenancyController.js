'use strict';

var app = angular.module('UnifiedApiSpa');

app.controller('tenancyController', ['$scope', 'unifiedApiService', tenancyController]);

function tenancyController($scope, unifiedApiService) {

  unifiedApiService.getTenantDetails().success(function (data) {
    $scope.tenantDetails = data.value[0];
  }).
  error(function (data, status, headers, config) {
    alert("Error getting tenant details");
  });


}
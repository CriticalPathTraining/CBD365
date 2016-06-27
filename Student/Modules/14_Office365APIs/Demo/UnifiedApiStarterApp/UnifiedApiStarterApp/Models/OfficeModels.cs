using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnifiedApiStarterApp.Models {

  public class AssignedLicens {
    public List<object> disabledPlans { get; set; }
    public string skuId { get; set; }
  }

  public class AssignedPlan {
    public string assignedTimestamp { get; set; }
    public string capabilityStatus { get; set; }
    public string service { get; set; }
    public string servicePlanId { get; set; }
  }

  public class ProvisionedPlan {
    public string capabilityStatus { get; set; }
    public string provisioningStatus { get; set; }
    public string service { get; set; }
  }

  public class OfficeUser {
    public string objectType { get; set; }
    public string objectId { get; set; }
    public object deletionTimestamp { get; set; }
    public bool accountEnabled { get; set; }
    public List<AssignedLicens> assignedLicenses { get; set; }
    public List<AssignedPlan> assignedPlans { get; set; }
    public string city { get; set; }
    public string country { get; set; }
    public object department { get; set; }
    public object dirSyncEnabled { get; set; }
    public string displayName { get; set; }
    public object facsimileTelephoneNumber { get; set; }
    public string givenName { get; set; }
    public object immutableId { get; set; }
    public object jobTitle { get; set; }
    public object lastDirSyncTime { get; set; }
    public string mail { get; set; }
    public string mailNickname { get; set; }
    public object mobile { get; set; }
    public object onPremisesSecurityIdentifier { get; set; }
    public List<string> otherMails { get; set; }
    public object passwordPolicies { get; set; }
    public object passwordProfile { get; set; }
    public object physicalDeliveryOfficeName { get; set; }
    public string postalCode { get; set; }
    public string preferredLanguage { get; set; }
    public List<ProvisionedPlan> provisionedPlans { get; set; }
    public List<object> provisioningErrors { get; set; }
    public List<string> proxyAddresses { get; set; }
    public string sipProxyAddress { get; set; }
    public string state { get; set; }
    public object streetAddress { get; set; }
    public string surname { get; set; }
    public string telephoneNumber { get; set; }
    public string usageLocation { get; set; }
    public string userPrincipalName { get; set; }
    public string userType { get; set; }
  }
  

}

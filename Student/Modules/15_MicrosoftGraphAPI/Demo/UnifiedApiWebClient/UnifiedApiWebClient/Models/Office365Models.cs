using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UnifiedApiWebClient.Models {

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
    public string department { get; set; }
    public object dirSyncEnabled { get; set; }
    public string displayName { get; set; }
    public object facsimileTelephoneNumber { get; set; }
    public string givenName { get; set; }
    public object immutableId { get; set; }
    public string jobTitle { get; set; }
    public object lastDirSyncTime { get; set; }
    public string mail { get; set; }
    public string mailNickname { get; set; }
    public object mobile { get; set; }
    public object onPremisesSecurityIdentifier { get; set; }
    public List<object> otherMails { get; set; }
    public string passwordPolicies { get; set; }
    public object passwordProfile { get; set; }
    public string physicalDeliveryOfficeName { get; set; }
    public string postalCode { get; set; }
    public string preferredLanguage { get; set; }
    public List<ProvisionedPlan> provisionedPlans { get; set; }
    public List<object> provisioningErrors { get; set; }
    public List<string> proxyAddresses { get; set; }
    public string sipProxyAddress { get; set; }
    public string state { get; set; }
    public string streetAddress { get; set; }
    public string surname { get; set; }
    public string telephoneNumber { get; set; }
    public string usageLocation { get; set; }
    public string userPrincipalName { get; set; }
    public string userType { get; set; }
  }

  public class OfficeUsersResult {
    public List<OfficeUser> value { get; set; }
  }

  public class UserInfo {
    public string userPrincipalName { get; set; }
    public string objectId { get; set; }
    public string usageLocation { get; set; }
    public string displayName { get; set; }
    public string department { get; set; }
    public string jobTitle { get; set; }
    public string mail { get; set; }
    public string telephoneNumber { get; set; }

    public string surname { get; set; }
    public string givenName { get; set; }
    public string streetAddress { get; set; }
    public string city { get; set; }
    public string state { get; set; }
    public string postalCode { get; set; }
    public string country { get; set; }
    public string photoUrl { get; set; }
  }


  public class Body {
    public string ContentType { get; set; }
    public string Content { get; set; }
  }

  public class Location {
    public string DisplayName { get; set; }
  }

  public class EmailAddress {
    public string Address { get; set; }
    public string Name { get; set; }
  }

  public class Status {
    public string Response { get; set; }
    public string Time { get; set; }
  }

  public class Attendee {
    public EmailAddress EmailAddress { get; set; }
    public Status Status { get; set; }
    public string Type { get; set; }
  }

  public class EmailAddress2 {
    public string Address { get; set; }
    public string Name { get; set; }
  }

  public class Organizer {
    public EmailAddress2 EmailAddress { get; set; }
  }


  public class OfficeCalendarEvent {
    public string Id { get; set; }
    public string DateTimeCreated { get; set; }
    public string Subject { get; set; }
    public Body Body { get; set; }
    public string Importance { get; set; }
    public bool HasAttachments { get; set; }
    public DateTime Start { get; set; }
    public string StartTimeZone { get; set; }
    public DateTime End { get; set; }
    public string EndTimeZone { get; set; }
    public Location Location { get; set; }
    public string ShowAs { get; set; }
    public bool IsAllDay { get; set; }
    public bool IsCancelled { get; set; }
    public string Type { get; set; }
    public string SeriesMasterId { get; set; }
    public List<Attendee> Attendees { get; set; }
    public object Recurrence { get; set; }
    public Organizer Organizer { get; set; }
    public string WebLink { get; set; }
  }

  public class OfficeCalendarEventCollection {
    public List<OfficeCalendarEvent> value { get; set; }
  }

  public class VerifiedDomain {
    public string capabilities { get; set; }
    public bool @default { get; set; }
    public string id { get; set; }
    public bool initial { get; set; }
    public string name { get; set; }
    public string type { get; set; }
  }


  public class OfficeTenant {
    public string objectType { get; set; }
    public string objectId { get; set; }
    public object deletionTimestamp { get; set; }
    public List<AssignedPlan> assignedPlans { get; set; }
    public object city { get; set; }
    public object companyLastDirSyncTime { get; set; }
    public object country { get; set; }
    public string countryLetterCode { get; set; }
    public object dirSyncEnabled { get; set; }
    public string displayName { get; set; }
    public List<object> marketingNotificationEmails { get; set; }
    public object postalCode { get; set; }
    public string preferredLanguage { get; set; }
    public List<ProvisionedPlan> provisionedPlans { get; set; }
    public List<object> provisioningErrors { get; set; }
    public List<object> securityComplianceNotificationMails { get; set; }
    public List<object> securityComplianceNotificationPhones { get; set; }
    public object state { get; set; }
    public object street { get; set; }
    public List<string> technicalNotificationMails { get; set; }
    public string telephoneNumber { get; set; }
    public List<VerifiedDomain> verifiedDomains { get; set; }
  }

  public class OfficeTenantResult {
    public List<OfficeTenant> value { get; set; }
  }
  
  public class Sender {
    public EmailAddress EmailAddress { get; set; }
  }
  
  public class From {
    public EmailAddress2 EmailAddress { get; set; }
  }

  public class EmailAddress3 {
    public string Address { get; set; }
    public string Name { get; set; }
  }

  public class ToRecipient {
    public EmailAddress3 EmailAddress { get; set; }
  }

  public class OfficeMessage {
    public string Id { get; set; }
    public string ChangeKey { get; set; }
    public List<object> Categories { get; set; }
    public string DateTimeCreated { get; set; }
    public string DateTimeLastModified { get; set; }
    public bool HasAttachments { get; set; }
    public string Subject { get; set; }
    public Body Body { get; set; }
    public string BodyPreview { get; set; }
    public string Importance { get; set; }
    public string ParentFolderId { get; set; }
    public Sender Sender { get; set; }
    public From From { get; set; }
    public List<ToRecipient> ToRecipients { get; set; }
    public List<object> CcRecipients { get; set; }
    public List<object> BccRecipients { get; set; }
    public List<object> ReplyTo { get; set; }
    public string ConversationId { get; set; }
    public bool IsDeliveryReceiptRequested { get; set; }
    public bool IsReadReceiptRequested { get; set; }
    public bool IsRead { get; set; }
    public bool IsDraft { get; set; }
    public string DateTimeReceived { get; set; }
    public string DateTimeSent { get; set; }
    public string WebLink { get; set; }
  }

  public class OfficeMessageCollection {
    public List<OfficeMessage> value { get; set; }
  }
}
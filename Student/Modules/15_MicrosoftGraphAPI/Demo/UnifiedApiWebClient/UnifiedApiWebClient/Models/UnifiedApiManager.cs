using Microsoft.IdentityModel.Clients.ActiveDirectory;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace UnifiedApiWebClient.Models {
  public class UnifiedApiManager {

    #region "Unified API Urls"

    public const string urlUnifiedApiResource = "https://graph.microsoft.com/";
    public const string urlUnifiedApiRoot = "https://graph.microsoft.com/beta/";

    public const string urlCurrentUser = urlUnifiedApiRoot + "me/";
    public const string urlCurrentUserCalendar = urlCurrentUser + "calendar/";
    public const string urlCurrentUserMessages = urlCurrentUser + "messages/";
    public const string urlCurrentUserEvents = urlCurrentUser + "events/";
    public const string urlCurrentUserFiles = urlCurrentUser + "files/";
    public const string urlCurrentUserPhoto = urlCurrentUser + "userPhoto/";
    public const string urlCurrentUserManager = urlCurrentUser + "manager/";
    public const string urlCurrentUserDirectReports = urlCurrentUser + "directReports/";
    public const string urlCurrentUserMemberOf = urlCurrentUser + "memberOf/";
    public const string urlCurrentUserTrendingAround = urlCurrentUser + "TrendingAround/";
    public const string urlCurrentUserWorkingWith = urlCurrentUser + "WorkingWith/";


    public const string urlCurrentTenant = urlUnifiedApiRoot + "myOrganization/";
    public const string urlTenantDetails = urlCurrentTenant + "tenantDetails/";
    public const string urlUsers = urlCurrentTenant + "users/";
    public const string urlGroups = urlCurrentTenant + "groups/";
    public const string urlContacts = urlCurrentTenant + "contacts/";
    public const string urlApplications = urlCurrentTenant + "applications/";
    public const string urlPermissions = urlCurrentTenant + "oauth2PermissionGrants/";
    public const string urlServicePrincipals = urlCurrentTenant + "servicePrincipals/";
    public const string urlDeviceConfiguration = urlCurrentTenant + "deviceConfiguration/";
    public const string urlDevices = urlCurrentTenant + "devices/";

    #endregion

    #region "Private Utility Functions"

    private static async Task<string> GetAccessTokenAsync() {

      // determine authorization URL for current tenant
      string authorizationUrlRoot = ConfigurationManager.AppSettings["ida:AADInstance"];
      string tenantID = ClaimsPrincipal.Current.FindFirst("http://schemas.microsoft.com/identity/claims/tenantid").Value;
      string authorizationUrlTenant = authorizationUrlRoot + tenantID;

      // create ADAL cache object
      ApplicationDbContext db = new ApplicationDbContext();
      string signedInUserID = ClaimsPrincipal.Current.FindFirst(ClaimTypes.NameIdentifier).Value;
      ADALTokenCache userTokenCache = new ADALTokenCache(signedInUserID);

      // create authentication context
      AuthenticationContext authenticationContext = new AuthenticationContext(authorizationUrlTenant, userTokenCache);

      // determine the resources to be accessed
      string unifiedApiResourceId = "https://graph.Microsoft.com";

      // create client credential object using client ID and client secret
      string clientId = ConfigurationManager.AppSettings["ida:ClientId"];
      string clientSecret = ConfigurationManager.AppSettings["ida:ClientSecret"];
      ClientCredential clientCredential = new ClientCredential(clientId, clientSecret);

      // create user identifier object for logged on user
      string objectIdentifierId = "http://schemas.microsoft.com/identity/claims/objectidentifier";
      string userObjectID = ClaimsPrincipal.Current.FindFirst(objectIdentifierId).Value;
      UserIdentifier userIdentifier = new UserIdentifier(userObjectID, UserIdentifierType.UniqueId);

      // get access token for Office 365 unifed API from AAD
      AuthenticationResult authenticationResult =
        await authenticationContext.AcquireTokenSilentAsync(unifiedApiResourceId, clientCredential, userIdentifier);

      // return access token back to user
      return authenticationResult.AccessToken;

    }

    private static async Task<string> ExecuteGetRequest(string urlRestEndpoint) {

      string accessToken = await GetAccessTokenAsync();

      HttpClient client = new HttpClient();
      HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, urlRestEndpoint);
      request.Headers.Add("Authorization", "Bearer " + accessToken);
      request.Headers.Add("Accept", "application/json;odata.metadata=minimal");

      HttpResponseMessage response = await client.SendAsync(request);

      if (response.StatusCode != HttpStatusCode.OK) {
        throw new ApplicationException("Error!!!!!");
      }

      return await response.Content.ReadAsStringAsync();             
    }

    #endregion

    public static async Task<OfficeUser> GetCurrentUser() {
      string jsonResult = await ExecuteGetRequest(urlCurrentUser);
      OfficeUser user = JsonConvert.DeserializeObject<OfficeUser>(jsonResult);
      return user;
    }

    public static async Task<OfficeMessageCollection> GetInbox() {
      string jsonResult = await ExecuteGetRequest(urlCurrentUserMessages);
      OfficeMessageCollection messages = JsonConvert.DeserializeObject<OfficeMessageCollection>(jsonResult);
      return messages;
    }


    public static async Task<OfficeTenant> GetTenantDetails() {
      string jsonResult = await ExecuteGetRequest(urlTenantDetails);
      OfficeTenantResult tenantResult = JsonConvert.DeserializeObject<OfficeTenantResult>(jsonResult);
      OfficeTenant tenant = tenantResult.value.First();
      return tenant;
    }

    public static async Task<List<OfficeUser>> GetUsers() {
      string jsonResult = await ExecuteGetRequest(urlUsers);
      OfficeUsersResult usersResult = JsonConvert.DeserializeObject<OfficeUsersResult>(jsonResult);
      List<OfficeUser> users = usersResult.value;
      return users;
    }

    public static async Task<OfficeUser> GetUser(string objectId) {
      string urlUser = urlUsers + objectId + "/";
      string jsonResult = await ExecuteGetRequest(urlUser);
      OfficeUser user = JsonConvert.DeserializeObject<OfficeUser>(jsonResult);
      return user;
    }
  }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Microsoft.IdentityModel.Clients.ActiveDirectory;

using Microsoft.Graph;
using System.Net.Http;
using System.Net;
using UnifiedApiStarterApp.Models;
using Newtonsoft.Json;

namespace UnifiedApiStarterApp {

  class Program {

    #region "Application constants"

    // login authority for Office 365
    const string authority = "https://login.microsoftonline.com/common";

    // TODO - add tenant-specific information
    const string tenantName = "CptLabs";
    const string tenantDomain = tenantName + ".onMicrosoft.com";

    // TODO: add application-specific information from Azure Active Directory
    const string clientID = "3283aa4d-d4bf-437c-af2a-aebd31bad617";
    const string redirectUri = "https://localhost/app1";
 
    // Urls for using Office Graph API
    const string resourceOfficeGraphAPI = "https://graph.microsoft.com";
    const string rootOfficeGraphAPI     = "https://graph.microsoft.com/beta/";
    const string urlHostTenancy         = "https://graph.microsoft.com/beta/myOrganization";

    #endregion

    #region "Access token management"

    // add field to cache access token
    protected static string AccessToken = string.Empty;

    private static string GetAccessToken() {

      // fetch access token from for Office Graph API if AccessToken is null
      if (string.IsNullOrEmpty(AccessToken)) {

        // create new authentication context
        var authenticationContext = new AuthenticationContext(authority, false);

        // use authentication context to trigger user sign-in and return access token
        var userAuthnResult = authenticationContext.AcquireToken(resourceOfficeGraphAPI,
                                                                 clientID,
                                                                 new Uri(redirectUri),
                                                                 PromptBehavior.Auto);
        // cache access token for reuse
        AccessToken = userAuthnResult.AccessToken;
      }
      // return access token to caller
      return AccessToken;
    }

    #endregion

    static void Main() {

      // call to Unified API using direct REST calls
     // DisplayCurrentUserInfo_REST();

      // call to Unified API using .NET client
      DisplayCurrentUserInfo_DotNet();
      DisplayFiles_DotNet();

      Console.WriteLine();
      Console.WriteLine("Press ENTER to end program");
      Console.ReadLine();
    }

    static void DisplayCurrentUserInfo_REST() {

      string urlRestEndpoint = "https://graph.microsoft.com/beta/me/";

      HttpClient client = new HttpClient();
      HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, urlRestEndpoint);
      request.Headers.Add("Authorization", "Bearer " + GetAccessToken());
      request.Headers.Add("Accept", "application/json;odata.metadata=minimal");

      HttpResponseMessage response = client.SendAsync(request).Result;

      if (response.StatusCode != HttpStatusCode.OK) {
        throw new ApplicationException("Error!!!!!");
      }

      string jsonResult = response.Content.ReadAsStringAsync().Result;
      OfficeUser user = JsonConvert.DeserializeObject<OfficeUser>(jsonResult);
      Console.WriteLine("Current user info obtained with REST");
      Console.WriteLine("------------------------------------");
      Console.WriteLine("Display Name: " + user.displayName);
      Console.WriteLine("First Name: " + user.givenName);
      Console.WriteLine("Last Name: " + user.surname);
      Console.WriteLine("User Principal Name: " + user.userPrincipalName);
      Console.WriteLine();
    }


    // add function to fetch and cache access token
    private static Task<string> AcquireTokenForUser() {
      // return access token to caller
      return Task.FromResult(GetAccessToken());
    }


    static void DisplayCurrentUserInfo_DotNet() {

      // create .NET client proxy for Unified API
      GraphService client = new GraphService(new Uri(urlHostTenancy), AcquireTokenForUser);

      // call across Internet and wait for response
      IUser user = client.Me.ExecuteAsync().Result;

      Console.WriteLine("Current user info obtained with .NET Client");
      Console.WriteLine("-------------------------------------------");
      Console.WriteLine("Current user info obtained with REST:");
      Console.WriteLine("Display Name: " + user.displayName);
      Console.WriteLine("First Name: " + user.givenName);
      Console.WriteLine("Last Name: " + user.surname);
      Console.WriteLine("User Principal Name: " + user.userPrincipalName);
      Console.WriteLine();
    }

    static void DisplayFiles_DotNet() {

      // create .NET client proxy for Unified API
      GraphService client = new GraphService(new Uri(urlHostTenancy), AcquireTokenForUser);

      // get files from OneDrive site of current user
      var files = client.Me.files.Query.ExecuteAsync().Result;

      Console.WriteLine("Current user files obtained with .NET Client");
      Console.WriteLine("--------------------------------------------");
      foreach (Microsoft.Graph.Item item in files) {
        Console.WriteLine(" - " + item.name + " [" + (item.size/1000).ToString("#.0") + " MB]");
      }
      Console.WriteLine();


    }


  }
}

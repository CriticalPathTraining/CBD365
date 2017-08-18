using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security;
using System.Text;
using System.Threading.Tasks;

namespace AppInstallerDemo {
  class Program {

    private static string siteUrl = "https://YOUR_DEV_SITE.sharepoint.com/";
    private static Guid AddinProductId = new Guid("2ab41d1e-c8a8-400a-ad6e-7c15fee6a69a");
    private static ClientContext clientContext;
    private static Web site;

    static void Main() {
     

    }

    static void EnsureClientContext() {


      // get client context
      ClientContext clientContext = new ClientContext(siteUrl);
      Web site = clientContext.Web;

      string user = ConfigurationManager.AppSettings["User"];
      string password = ConfigurationManager.AppSettings["Password"];
      SecureString securePassword = new SecureString();
      foreach (char c in password) {
        securePassword.AppendChar(c);
      }

      clientContext.Credentials = new SharePointOnlineCredentials(user, securePassword);

      clientContext.Load(site);
      clientContext.ExecuteQuery();

      Console.WriteLine("Connected to SPO site with title of " + site.Title);

    }

    static void InstallV1() {
      System.IO.MemoryStream addin1 = new System.IO.MemoryStream(Properties.Resources.CalculatorV1);    
      site.LoadAndInstallApp(addin1);
      site.
      clientContext.ExecuteQuery();
      Console.WriteLine("Add-in has been installed...");
    }

    static void UpgradeToV2() {
      var apps = site.GetAppInstancesByProductId(AddinProductId);
      clientContext.Load(apps);
      clientContext.ExecuteQuery();
      var app = apps.First();
      System.IO.MemoryStream addin2 = new System.IO.MemoryStream(Properties.Resources.CalculatorV2);
      app.Upgrade(addin2);
      clientContext.ExecuteQuery();
      Console.WriteLine("Add-in upgrade from v1.0 to v2.0");
    }

    static void Uninstall() {
      var apps = site.GetAppInstancesByProductId(AddinProductId);
      clientContext.Load(apps);
      clientContext.ExecuteQuery();
      var app = apps.First();
      app.Uninstall();
      clientContext.ExecuteQuery();
      Console.WriteLine("Add-in uninstalled");
    }
  }
}

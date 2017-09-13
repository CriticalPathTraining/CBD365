using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.SharePoint.Client;
using System.Security;

namespace Csom101 {
  class Program {
    static void Main() {

      string url = "https://cpt0828.sharepoint.com/sites/weds";

      ClientContext clientContext = new ClientContext(url);

      string un = "student@cpt0828.onMicrosoft.com";
      string pwd = "Pa$$word!";
      SecureString spwd = new SecureString(); 
      foreach(char c in pwd) {
        spwd.AppendChar(c);
      }

      clientContext.Credentials = new SharePointOnlineCredentials(un, spwd);

      Site sc = clientContext.Site;
      Web site = clientContext.Web;
      ListCollection lists = site.Lists;

      //clientContext.Load(site, s => s.Title, s => s.Url );
      clientContext.Load(lists);
      clientContext.ExecuteQuery();

      Console.WriteLine(site.Title);

      foreach(var list in lists) {
        Console.WriteLine(list.Title);
      }



    }
  }
}

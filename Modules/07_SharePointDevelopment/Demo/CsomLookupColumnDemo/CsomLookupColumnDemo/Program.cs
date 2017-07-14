using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CsomLookupColumnDemo {
  class Program {
    static void Main() {

      string url = "http://intranet.wingtip.com";
      ClientContext clientContext = new ClientContext(url);
      
      Web site = clientContext.Web;
      clientContext.ExecuteQuery();

      ExceptionHandlingScope scope1 = new ExceptionHandlingScope(clientContext);
      using (scope1.StartScope()) {
        using (scope1.StartTry()) {
          site.Lists.GetByTitle("Teams").DeleteObject();
        }
        using (scope1.StartCatch()) { }
      }

      ExceptionHandlingScope scope2 = new ExceptionHandlingScope(clientContext);
      using (scope2.StartScope()) {
        using (scope2.StartTry()) {
          site.Lists.GetByTitle("Players").DeleteObject();
        }
        using (scope2.StartCatch()) { }
      }
      


      ListCreationInformation ciTeams = new ListCreationInformation();
      ciTeams.Title = "Teams";
      ciTeams.Url = "Lists/Teams";
      ciTeams.QuickLaunchOption = QuickLaunchOptions.On;
      ciTeams.TemplateType = (int)ListTemplateType.GenericList;

      List Teams = site.Lists.Add(ciTeams);
      Teams.EnableAttachments = false;
      Teams.Update();

      ListItem team1 = Teams.AddItem(new ListItemCreationInformation());
      team1["Title"] = "Boston Celtics";
      team1.Update();

      ListItem team2 = Teams.AddItem(new ListItemCreationInformation());
      team2["Title"] = "LA Lakers";
      team2.Update();

      clientContext.Load(Teams);
      clientContext.ExecuteQuery();


      ListCreationInformation ciPlayers = new ListCreationInformation();
      ciPlayers.Title = "Players";
      ciPlayers.Url = "Lists/Players";
      ciPlayers.QuickLaunchOption = QuickLaunchOptions.On;
      ciPlayers.TemplateType = (int)ListTemplateType.GenericList;

      List Players = site.Lists.Add(ciPlayers);
      Players.EnableAttachments = false;
      Players.Update();

      string fieldXML = @"<Field Name='Team' " +
                                "DisplayName='Team' " +
                                "Type='Lookup' > " +
                         "</Field>";

      FieldLookup lookup = clientContext.CastTo<FieldLookup>(Players.Fields.AddFieldAsXml(fieldXML, true, AddFieldOptions.DefaultValue));
      lookup.LookupField = "Title";
      lookup.LookupList = Teams.Id.ToString();
      lookup.Update();

      Console.WriteLine("ID: " + Teams.Id.ToString());

      clientContext.ExecuteQuery();


    }
  }
}

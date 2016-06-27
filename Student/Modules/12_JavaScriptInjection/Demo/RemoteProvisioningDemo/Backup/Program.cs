using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Microsoft.SharePoint.Client;
using System.Security;
using System.Net;

namespace RemoteProvisioningDemo {
  class Program {

    static ClientContext clientContext;
    static Site siteCollection;
    static Web site;
    static List CustomPagesLibrary;
    static string CustomPagesLibraryAbsoluteUrl;
    static string CustomPagesLibraryRelativeUrl;
    static Folder siteRootFolder;
    static List MasterPageGallery;
    static string ScriptsFolderName = "CPT";
    static Folder ScriptsFolder;
    static string ScriptsFolderRelativeUrl;
    static string ScriptsFolderAbsoluteUrl;

    static NavigationNodeCollection TopNavNodes;
    static List listArtists;

    static void InitializeClientContext(string targetsite) {

      // create new client context
      clientContext = new ClientContext(targetsite);
      // get user name and secure password
      string userName = ConfigurationManager.AppSettings["accessAccountName"];
      string pwd = ConfigurationManager.AppSettings["accessAccountPassword"];
      SecureString spwd = new SecureString();
      foreach (char c in pwd.ToCharArray()) {
        spwd.AppendChar(c);
      }
      // create credentials for SharePoint Online using Office 365 user account
      clientContext.Credentials = new SharePointOnlineCredentials(userName, spwd);

      // initlaize static variables for client context, web and site
      siteCollection = clientContext.Site;
      clientContext.Load(siteCollection);
      site = clientContext.Web;
      clientContext.Load(site);
      siteRootFolder = site.RootFolder;
      clientContext.Load(siteRootFolder);
      clientContext.Load(site.Lists);

      TopNavNodes = site.Navigation.TopNavigationBar;
      clientContext.Load(TopNavNodes);
      clientContext.ExecuteQuery();

      MasterPageGallery = site.Lists.Single(list => list.BaseTemplate.Equals(116));
      clientContext.Load(MasterPageGallery);
      clientContext.Load(MasterPageGallery.RootFolder);
      clientContext.ExecuteQuery();
    }


    static void Main() {

      InitializeClientContext("https://CptLabs.sharepoint.com");

      DeleteAllTopNavNodes();
      EnsureCustomPagesLibrary();

      UpdateCustomPages();



    }

    static void EnsureCustomPagesLibrary() {

      string libraryTitle = "Custom Pages";
      string libraryUrl = "CustomPages";

      // delete document library if it already exists
      ExceptionHandlingScope scope = new ExceptionHandlingScope(clientContext);
      using (scope.StartScope()) {
        using (scope.StartTry()) {
          site.Lists.GetByTitle(libraryTitle).DeleteObject();
        }
        using (scope.StartCatch()) { }
      }

      ListCreationInformation lci = new ListCreationInformation();
      lci.Title = libraryTitle;
      lci.Url = libraryUrl;
      lci.TemplateType = (int)ListTemplateType.DocumentLibrary;
      CustomPagesLibrary = site.Lists.Add(lci);
      CustomPagesLibrary.OnQuickLaunch = true;
      CustomPagesLibrary.Update();
      CustomPagesLibrary.RootFolder.Folders.Add("content");
      CustomPagesLibrary.RootFolder.Folders.Add("scripts");
      clientContext.Load(CustomPagesLibrary);
      clientContext.ExecuteQuery();

      CustomPagesLibraryRelativeUrl = "~site/" + libraryUrl + "/";
      CustomPagesLibraryAbsoluteUrl = site.Url + "/" + libraryUrl + "/";

    }

    static void UploadToCustomPagesLibrary(string path, byte[] content) {

      string filePath = CustomPagesLibraryAbsoluteUrl + path;
      Console.WriteLine(filePath);
      FileCreationInformation fileInfo = new FileCreationInformation();
      fileInfo.Content = content;
      fileInfo.Overwrite = true;
      fileInfo.Url = filePath;
      File newFile = CustomPagesLibrary.RootFolder.Files.Add(fileInfo);
      clientContext.ExecuteQuery();

    }

    static void UpdateCustomPages() {
      UploadToCustomPagesLibrary("content/styles.css", Properties.Resources.styles_css);

      UploadToCustomPagesLibrary("scripts/SiteProperties.js", Properties.Resources.SiteProperties_js);
      UploadToCustomPagesLibrary("SiteProperties.aspx", Properties.Resources.SiteProperties_aspx);
      CreateTopNavNode("Site Properties", "SiteProperties.aspx");

      UploadToCustomPagesLibrary("scripts/GetUserInformation.js", Properties.Resources.GetUserInformation_js);
      UploadToCustomPagesLibrary("GetUserInformation.aspx", Properties.Resources.GetUserInformation_aspx);
      CreateTopNavNode("Get User Info", "GetUserInformation.aspx");

      UploadToCustomPagesLibrary("Configuration.aspx", Properties.Resources.Configuration_aspx);
      CreateTopNavNode("Configuration", "Configuration.aspx");

    }

    static void EnsureScriptsFolder() {

      var folders = MasterPageGallery.RootFolder.Folders;
      site.Context.Load(folders);
      site.Context.ExecuteQuery();
      // delete scripts folder is it already exists
      if (Enumerable.Any(folders, folder => folder.Name == ScriptsFolderName)) {
        Console.WriteLine("Deleting existing scripts folder");
        MasterPageGallery.RootFolder.Folders.GetByUrl(ScriptsFolderName).DeleteObject();
        clientContext.ExecuteQuery();
      }

      // create scripts folder
      ScriptsFolder = MasterPageGallery.RootFolder.Folders.Add(ScriptsFolderName);
      clientContext.Load(ScriptsFolder);
      clientContext.ExecuteQuery();

      ScriptsFolderRelativeUrl = "~site/_catalogs/masterpage/" + ScriptsFolderName + "/";
      ScriptsFolderAbsoluteUrl = site.Url + "/_catalogs/masterpage/" + ScriptsFolderName + "/";

      Console.WriteLine("Script folder relative url: " + ScriptsFolderRelativeUrl);
      Console.WriteLine("Script folder absolute url: " + ScriptsFolderAbsoluteUrl);
    }

    static void CreateTopNavNode(string title, string path) {
      string nodeUrl = CustomPagesLibraryAbsoluteUrl + path;
      NavigationNodeCreationInformation newNode = new NavigationNodeCreationInformation();
      newNode.IsExternal = false;
      newNode.Title = title;
      newNode.Url = nodeUrl;
      newNode.AsLastNode = true;
      TopNavNodes.Add(newNode);
      clientContext.ExecuteQuery();
    }

    static void DeleteAllTopNavNodes() {
      // delete all existing nodes
      for (int index = (TopNavNodes.Count - 1); index >= 0; index--) {
        ExceptionHandlingScope scope = new ExceptionHandlingScope(clientContext);
        using (scope.StartScope()) {
          using (scope.StartTry()) {
            TopNavNodes[index].DeleteObject();
          }
          using (scope.StartCatch()) {
          }
        }
        clientContext.ExecuteQuery();
      }
      clientContext.Load(TopNavNodes);
      clientContext.ExecuteQuery();
      // add back in Home node
      AddHomeTopNavNode();
    }

    static void AddHomeTopNavNode() {
      NavigationNodeCreationInformation newNode = new NavigationNodeCreationInformation();
      newNode.IsExternal = false;
      newNode.Title = "Home";
      newNode.Url = site.Url;
      newNode.AsLastNode = true;
      TopNavNodes.Add(newNode);
      clientContext.ExecuteQuery();

    }
  }
}

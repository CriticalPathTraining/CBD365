<%  @Page MasterPageFile="~masterurl/default.master"    
          Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage,Microsoft.SharePoint,Version=16.0.0.0,Culture=neutral,PublicKeyToken=71e9bce111e9429c" %>


<asp:Content ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
  
  <script src="https://code.jquery.com/jquery-2.1.4.js" ></script>
  <script src="scripts/SiteProperties.js"></script>

</asp:Content>


<asp:Content ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
  Site Properties
</asp:Content>


<asp:Content ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
  Site Properties
</asp:Content>


<asp:Content ContentPlaceHolderID="PlaceHolderMain" runat="server">
  
  <div>
    <button id="getSiteProperties" type="button" >Get Site Properties</button>
    <button id="getLists" type="button" >Get Lists</button>
  </div>
  
  <div id="content_box" />

</asp:Content>

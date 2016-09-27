<%  @Page MasterPageFile="~masterurl/default.master"    
          Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage,Microsoft.SharePoint,Version=16.0.0.0,Culture=neutral,PublicKeyToken=71e9bce111e9429c" %>


<asp:Content ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
  <link href="content/styles.css" rel="stylesheet" />
  <script src="https://code.jquery.com/jquery-2.1.4.js" ></script>
  <script src="scripts/GetUserInformation.js"></script> 
</asp:Content>

<asp:Content ContentPlaceHolderID="PlaceHolderMain" runat="server">
  
  <div id="content_box" >getting user info...</div>

</asp:Content>


<asp:Content ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
  Current User Info
</asp:Content>


<asp:Content ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
  Current User Info
</asp:Content>

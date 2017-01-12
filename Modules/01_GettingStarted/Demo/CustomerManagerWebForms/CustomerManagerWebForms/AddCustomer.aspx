<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddCustomer.aspx.cs" Inherits="CustomerManagerWebForms.AddCustomer" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Add Customer</h2>

    <div class="form-horizontal">
        <fieldset>
            <div class="form-group">
                <label for="txtFirstName" class="col-lg-2 control-label">First Name:</label>
                <div class="col-lg-6">
                    <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label for="txtLastName" class="col-lg-2 control-label">Last Name:</label>
                <div class="col-lg-6">
                    <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                </div>
            </div>
          <div class="form-group">
                <label for="txtCompany" class="col-lg-2 control-label">Company:</label>
                <div class="col-lg-6">
                    <asp:TextBox ID="txtCompany" runat="server"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <label for="txtWorkPhone" class="col-lg-2 control-label">Work Phone:</label>
                <div class="col-lg-6">
                    <asp:TextBox ID="txtWorkPhone" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label for="txtHomePhone" class="col-lg-2 control-label">Home Phone:</label>
                <div class="col-lg-6">
                    <asp:TextBox ID="txtHomePhone" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label for="txtEMailAddress" class="col-lg-2 control-label">EMail Addresss:</label>
                <div class="col-lg-6">
                    <asp:TextBox ID="txtEMailAddress" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-offset-2">
                    <asp:Button ID="cmdAddCustomer" runat="server" Text="Add Customer" OnClick="cmdAddCustomer_Click" />
                    <asp:Button ID="cmdCancel" runat="server" Text="Cancel" />
                </div>
            </div>
        </fieldset>
    </div>

    <hr />

    <a href="#/">Return to customers list</a>
</asp:Content>

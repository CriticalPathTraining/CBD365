<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="CustomerManagerWebForms.Customers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Customer List</h2>
    <asp:GridView ID="gridCustomers" runat="server" CssClass="table"></asp:GridView>
</asp:Content>

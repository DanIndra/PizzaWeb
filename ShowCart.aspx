<%@ Page Title="" Language="C#" MasterPageFile="~/CS.master" AutoEventWireup="true" CodeFile="ShowCart.aspx.cs" Inherits="Default2" %>

<%@ Register src="Cart.ascx" tagname="Cart" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label1" runat="server" Text="Your Shopping Cart" 
        Font-Size="Larger" Font-Names="Script MT Bold" ForeColor="#666699"></asp:Label>
          <uc1:Cart ID="Cart1" runat="server" />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/CheckOut.aspx">
    Proceed to Checkout</asp:HyperLink><br />
</asp:Content>


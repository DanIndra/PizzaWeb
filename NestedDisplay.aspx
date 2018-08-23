<%@ Page Language="C#" MasterPageFile="~/CS.master" AutoEventWireup="false" 
CodeFile="NestedDisplay.aspx.cs" Inherits="Default2" title="Products" %>
<%@ Import Namespace ="System.Data" %>
<%@ Import Namespace ="System.Data.SqlClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Label ID="Label5" runat="server" Text="Cart is Empty" Font-Bold ="true"></asp:Label>
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/ShowCart.aspx">View Cart</asp:HyperLink>  
          
          <asp:DataList ID="DataList1" runat="server" BackColor="#CCCCCC" 
        BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" 
        CellSpacing="2" ForeColor="Black" GridLines="Both" Width="940px" 
    onitemdatabound="DataList1_ItemDataBound" >            
              <FooterStyle BackColor="#CCCCCC" />
              <ItemStyle BackColor="White" />
              <SeparatorStyle VerticalAlign="Middle" />
              <SelectedItemStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
              <SeparatorTemplate>
              </SeparatorTemplate>
              <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
              <ItemTemplate>
              
                 <asp:Image ID="Image1" runat="server" ImageAlign="Left"
                      ImageUrl='<%# Eval("Image", "images/{0}") %>' />
                  &nbsp;&nbsp;&nbsp;
                  <asp:Label ID="Label1" runat="server" style="font-weight: 700" 
                      Text='<%# Eval("Title") %>' Font-Bold="False"></asp:Label>
                  <br />
                  &nbsp;&nbsp;&nbsp; Published by:
                  <asp:Label ID="Label2" runat="server" Text='<%# Eval("Publisher") %>' 
                      Font-Bold="False"></asp:Label>
                  <br />
                  &nbsp;&nbsp;&nbsp; Age Rating:
                  <asp:Label ID="Label3" runat="server" 
                      Text='<%# Eval("Rating", "{0}") %>'></asp:Label>
                  <br />
                  &nbsp;&nbsp;&nbsp; Released Date:
                  <asp:Label ID="Label4" runat="server" Text='<%# Eval("Released", "{0:d}") %>'></asp:Label>
                  <br />
                  
                  <asp:Repeater ID="Repeater1" runat="server" 
                     DataSource='<%# ((DataRowView)Container.DataItem).CreateChildView("GamesLink") %>' 
                     OnItemCommand="Repeater1_ItemCommand">
                    <ItemTemplate> <span style = "color:Blue">                       
                        <%# Eval("Console") %>: <%#Eval("Price", "£{0:F2}")%> 
                        
                        <asp:LinkButton ID="OrderItem" runat="Server" ToolTip="Add Item to order"  
                          CommandName='<%# Eval("Console") %>' CommandArgument='<%# Eval("Price") %>' Font-Size="Small">
                          <asp:Image ID="CartIcon" runat="server" ImageUrl="~/Images/cartIcon.gif" 
                          AlternateText="Click to add Item to Shopping Cart" />
                        </asp:LinkButton>&nbsp; </span> 
                    </ItemTemplate>
                  </asp:Repeater>
                  
              </ItemTemplate>
          </asp:DataList>
</asp:Content>


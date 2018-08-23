<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Cart.ascx.cs" Inherits="Cart" %>
<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
    DeleteMethod="DeleteItem" InsertMethod="InsertItem" SelectMethod="ReadItems" 
    TypeName="StoredCart" UpdateMethod="UpdateItem">
    <DeleteParameters>
        <asp:Parameter Name="GameID" Type="Int32" />
        <asp:Parameter Name="Console" Type="String" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="GameID" Type="Int32" />
        <asp:Parameter Name="Console" Type="String" />
        <asp:Parameter Name="Quantity" Type="Int32" />
    </UpdateParameters>
    <InsertParameters>
        <asp:Parameter Name="GameID" Type="Int32" />
        <asp:Parameter Name="Title" Type="String" />
        <asp:Parameter Name="Console" Type="String" />
        <asp:Parameter Name="Quantity" Type="Int32" />
        <asp:Parameter Name="Price" Type="Decimal" />
    </InsertParameters>
</asp:ObjectDataSource>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="GameID,Console" DataSourceID="ObjectDataSource1">
    <Columns>
        <asp:CommandField InsertVisible="False" ShowDeleteButton="True" 
            ShowEditButton="True" />
        <asp:BoundField DataField="GameID" HeaderText="GameID" SortExpression="GameID" 
            Visible="False" />
        <asp:BoundField DataField="Title" HeaderText="Title" ReadOnly="True" 
            SortExpression="Title" />
        <asp:BoundField DataField="Console" HeaderText="Console" ReadOnly="True" 
            SortExpression="Console" />
        <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
            SortExpression="Quantity" />
        <asp:BoundField DataField="Price" DataFormatString="{0:c}" HeaderText="Price" 
            ReadOnly="True" SortExpression="Price" />
        <asp:BoundField DataField="SubTotal" DataFormatString="{0:c}" 
            HeaderText="SubTotal" ReadOnly="True" SortExpression="SubTotal" />
    </Columns>
    <EmptyDataTemplate>
        You have not ordered any items yet,<br />
        Please visit the order pages to add items to the cart.
    </EmptyDataTemplate>
</asp:GridView>

<%@ Page Language="C#" MasterPageFile="~/CS.master" AutoEventWireup="false" CodeFile="TestNested.aspx.cs" Inherits="Default2" title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"><a name="Content" />
     <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CSConnectionString %>" 
        SelectCommand="SELECT [GameID], [Title], [Publisher], [Rating], [Released], [Image] FROM [Games]">
    </asp:SqlDataSource>
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="GameID" DataSourceID="SqlDataSource1" Width="940px" 
        BorderColor="#999999" BorderStyle="Solid" 
        onrowdatabound="GridView1_RowDataBound1"><RowStyle BorderColor="Silver" BorderStyle="Solid" />
        <Columns>
            <asp:ImageField DataImageUrlField="Image" DataImageUrlFormatString="images/{0}" 
                HeaderText="Game">
                <HeaderStyle BorderColor="Gray" BorderStyle="Solid" />
                <ItemStyle BorderColor="#999999" BorderStyle="Solid" />
            </asp:ImageField>
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" >
            <HeaderStyle HorizontalAlign="Left" BorderColor="Gray" BorderStyle="Solid" />
            <ItemStyle BorderColor="#999999" BorderStyle="Solid" />
            </asp:BoundField>
            <asp:BoundField DataField="Publisher" HeaderText="Publisher" 
                SortExpression="Publisher" >
            <HeaderStyle HorizontalAlign="Left" BorderColor="Gray" BorderStyle="Solid" />
            <ItemStyle BorderColor="#999999" BorderStyle="Solid" />
            </asp:BoundField>
            <asp:BoundField DataField="Rating" HeaderText="Rating" 
                SortExpression="Rating" >
            <HeaderStyle HorizontalAlign="Center" BorderColor="Gray" BorderStyle="Solid" />
            <ItemStyle HorizontalAlign="Center" BorderColor="#999999" BorderStyle="Solid" />
            </asp:BoundField>
            <asp:BoundField DataField="Released" HeaderText="Released" 
                SortExpression="Released" DataFormatString="{0:d}" >
            <HeaderStyle BorderColor="Gray" BorderStyle="Solid" />
            <ItemStyle HorizontalAlign="Center" BorderColor="#999999" BorderStyle="Solid" />
            </asp:BoundField>
            
            <asp:TemplateField HeaderText="Format &amp; Price" ItemStyle-VerticalAlign="Middle">
                <ItemTemplate>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource2">
                    <ItemTemplate> 
                        <%# Eval("Console") %>: <%# Eval("Price", "£{0:F2}") %><br />  
                    </ItemTemplate>
                   </asp:Repeater>

                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:CSConnectionString %>" 
                        SelectCommand="SELECT [Console], [Price] FROM [Consoles] WHERE ([fkGameID] = @fkGameID)">
                        <SelectParameters>
                            <asp:Parameter Name="fkGameID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
                
                <HeaderStyle HorizontalAlign="Left" BorderColor="Gray" BorderStyle="Solid" />
                <ItemStyle HorizontalAlign="Left" ForeColor="#3333FF" VerticalAlign="Middle" BorderColor="#999999" BorderStyle="Solid" />
            </asp:TemplateField>
        </Columns>
        <HeaderStyle BackColor="#CCCCFF" BorderColor="#999999" BorderStyle="Solid" ForeColor="Black" BorderWidth="2px" />
        <EditRowStyle BorderColor="Silver" BorderStyle="Solid" />
    </asp:GridView>
    
</asp:Content>


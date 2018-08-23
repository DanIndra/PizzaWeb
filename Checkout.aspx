<%@ Page Title="" Language="C#" MasterPageFile="~/CS.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Default2" %>

<%@ Register src="Cart.ascx" tagname="Cart" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <asp:Wizard ID="Wizard1" runat="server" Width="70%" BackColor="#EFF3FB" 
                BorderColor="#003366" BorderWidth="1px" Font-Names="Verdana" Font-Size="1em" 
                ActiveStepIndex="2" Height="265px" DisplayCancelButton="True" 
                onfinishbuttonclick="Wizard1_FinishButtonClick" >
        <StepStyle Font-Size="Medium" ForeColor="#333333"></StepStyle>
        <SideBarButtonStyle BackColor="#006699" Font-Names="Verdana" ForeColor="White"></SideBarButtonStyle>
        <NavigationButtonStyle BackColor="White" BorderColor="#006699" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="1em" 
            ForeColor="#284E98"></NavigationButtonStyle>
        <SideBarStyle BackColor="#006699" Font-Size="Medium" VerticalAlign="Top" Width="20%"></SideBarStyle>
        <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" 
            BorderWidth="2px" Font-Bold="True" Font-Size="1em" ForeColor="White" HorizontalAlign="Center"></HeaderStyle>
        
        <WizardSteps>        
            <asp:WizardStep ID="WizardStep1" runat="server" title="Delivery Address" 
                StepType="Start">
              
                <table border="0" cellpadding="3" style="width: 100%; height: 100%;">
                    <tr>
                        <td style="width: 200px" valign="top">
                            Name
                        </td>
                        <td style="width: 400px" valign="top">
                            <asp:TextBox ID="txtName" runat="server" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px" valign="top">
                            Address
                        </td>
                        <td style="width: 400px" valign="top">
                            <asp:TextBox ID="txtAddress" runat="server" Columns="30" Rows="5" 
                                TextMode="MultiLine" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px" valign="top">
                            E-Mail
                        </td>
                        <td style="width: 400px" valign="top">
                            <asp:TextBox ID="txtEmail" runat="server" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px" valign="top">
                        </td>
                        <td style="width: 400px" valign="top">
                        </td>
                    </tr>
                </table>
            </asp:WizardStep>
      
            <asp:WizardStep ID="WizardStep2" runat="server" title="Payment" StepType="Step">
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" 
                    CausesValidation="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                    <asp:ListItem Selected="True" Value="COD">Cash on Delivery</asp:ListItem>
                    <asp:ListItem Value="CC">Credit Card</asp:ListItem>
                </asp:RadioButtonList>
                
                <asp:Panel ID="CreditCardPayment" runat="server" Visible="False">
                    Card Type: <asp:DropDownList ID="lstCardType" runat="server">
                        <asp:ListItem>MasterCard</asp:ListItem>
                        <asp:ListItem>Visa</asp:ListItem>
                    </asp:DropDownList>
                    <br />Card Number:
                    <asp:TextBox ID="txtCardNumber" runat="server"></asp:TextBox>
                    <br />Expires:
                    <asp:TextBox ID="txtExpiresMonth" runat="server" Columns="2"></asp:TextBox>
                    /
                    <asp:TextBox ID="txtExpiresYear" runat="server" Columns="4"></asp:TextBox>
                </asp:Panel>
            </asp:WizardStep>
            
            <asp:WizardStep ID="WizardStep3" runat="server" Title="Shopping Cart" 
                StepType="Finish">
                
                <uc1:Cart ID="Cart1" runat="server">
                </uc1:Cart>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="Read" 
                    TypeName="StoredCart" UpdateMethod="Update"> 
                    <UpdateParameters>
                        <asp:Parameter Name="DeliveryCharge" Type="Decimal" />
                        
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
                    DataSourceID="ObjectDataSource2" Height="50px" HorizontalAlign="Right" Width="100%">
                    <Fields>
                        <asp:BoundField DataField="Total" 
                            HeaderText="Total" SortExpression="Total" ReadOnly="True" />
                        <asp:BoundField DataField="DeliveryCharge" HeaderText="DeliveryCharge" 
                            SortExpression="DeliveryCharge" />
                    </Fields>
                </asp:DetailsView>
            </asp:WizardStep>
              
            <asp:WizardStep ID="WizardStep4" runat="server" Title="Order Complete" StepType="Complete">
                Thank you for your order<br /><br />
                <asp:Label ID="lblSuccess" runat="server" BorderStyle="Double" 
                    Font-Size="Small" ForeColor="#006699" Visible="False"> 
                    Your order has been processed successfully. Please allow 5 days for delivery
                </asp:Label>
                <asp:Label ID="lblError" runat="server" BorderStyle="Double" 
                    Font-Size="Small" ForeColor="#006699" Visible="False"> 
                    Sorry, but we are unable to complete your order at this time. Please try again later
                </asp:Label>
            </asp:WizardStep>
                              
        </WizardSteps>   
        <StepNavigationTemplate>
            <asp:Button ID="StepPreviousButton" runat="server" BackColor="White" 
                BorderColor="#006699" BorderStyle="Solid" BorderWidth="1px" 
                CausesValidation="False" CommandName="MovePrevious" Font-Names="Verdana" 
                Font-Size="1em" ForeColor="#284E98" Text="Previous" />
            <asp:Button ID="StepNextButton" runat="server" BackColor="White" 
                BorderColor="#006699" BorderStyle="Solid" BorderWidth="1px" 
                CommandName="MoveNext" Font-Names="Verdana" Font-Size="1em" ForeColor="#284E98" Text="Next" />
        </StepNavigationTemplate>
    </asp:Wizard>
</asp:Content>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration; 

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = (RadioButtonList)sender;
        Panel ccp = (Panel)Wizard1.FindControl("CreditCardPayment");

        if (rbl.SelectedValue == "CC")
        {
            ccp.Visible = true;
        }
        else
        {
            ccp.Visible = false;
        }
    }

    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        // Insert the order and order lines into the database
        SqlConnection conn = null;
        SqlTransaction trans = null;
        SqlCommand cmd = default(SqlCommand);
        ShoppingCart cart = StoredCart.Read();

        // if there is not shopping cart, then something has gone wrong 
        if (cart == null || cart.Items.Count == 0)
        {
            e.Cancel = true;
            return;
        }

        // try - catch protects us against exceptions
        try
        {
            int SaleID = 0;
            // Create and open a new connection to the database
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings
                                    ["CSConnectionString"].ConnectionString); 
            conn.Open();

            // Start a new transaction
            trans = conn.BeginTransaction();
            // create a new command - the stored procedures
            cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.Transaction = trans;

            // Set the order details: the name and type of the command
            cmd.CommandText = "spInsertSale";
            cmd.CommandType = CommandType.StoredProcedure;
            
            // Set up the parameters to pass to the database
            cmd.Parameters.Add("@SaleDate", SqlDbType.DateTime);
            cmd.Parameters.Add("@CustName", SqlDbType.VarChar, 50);
            cmd.Parameters.Add("@Address", SqlDbType.VarChar, 250);
            cmd.Parameters.Add("@Email", SqlDbType.VarChar, 50);
            cmd.Parameters.Add("@DeliveryCharge", SqlDbType.Money);
            cmd.Parameters.Add("@Total", SqlDbType.Money);
            cmd.Parameters.Add("@SaleID", SqlDbType.Int);

            // Set the values for the parameters
            cmd.Parameters["@SaleDate"].Value = DateTime.Now;
            cmd.Parameters["@CustName"].Value = ((TextBox)Wizard1.FindControl("txtName")).Text;
            cmd.Parameters["@Address"].Value = ((TextBox)Wizard1.FindControl("txtAddress")).Text;
            cmd.Parameters["@Email"].Value = ((TextBox)Wizard1.FindControl("txtEmail")).Text;
            cmd.Parameters["@DeliveryCharge"].Value = cart.DeliveryCharge;
            cmd.Parameters["@Total"].Value = cart.Total;
            cmd.Parameters["@SaleID"].Direction = ParameterDirection.Output;

            // Execute the query and fetch the output parameter - the generated Primary key
            cmd.ExecuteNonQuery();
            SaleID = Convert.ToInt32(cmd.Parameters["@SaleID"].Value);
            
            // Change the query and parameters for the order lines
            cmd.CommandText = "spInsertSalesItems";
            cmd.Parameters.Clear();
            cmd.Parameters.Add("@fkSaleID", SqlDbType.Int);
            cmd.Parameters.Add("@fkGameID", SqlDbType.Int);
            cmd.Parameters.Add("@Console", SqlDbType.VarChar, 10);
            cmd.Parameters.Add("@Title", SqlDbType.VarChar, 50);
            cmd.Parameters.Add("@Quantity", SqlDbType.Int);
            cmd.Parameters.Add("@SubTotal", SqlDbType.Money);
            cmd.Parameters["@fkSaleID"].Value = SaleID;

            // Loop through the items in the shopping cart adding each one
            foreach (CartItem item in cart.Items)
            {
                cmd.Parameters["@fkGameID"].Value = item.GameID;
                cmd.Parameters["@Console"].Value = item.Console;
                cmd.Parameters["@Title"].Value = item.Title;
                cmd.Parameters["@Quantity"].Value = item.Quantity;
                cmd.Parameters["@SubTotal"].Value = item.SubTotal;

                cmd.ExecuteNonQuery();
            }
            // If no errors save to database and confirm order onscreen
            trans.Commit();
            lblSuccess.Visible = true;
        }
        catch  
        {
            // If a problem occurs - undo database changes and inform customer
            if (trans != null)
            {
                trans.Rollback();
            }
            lblError.Visible = true;
            return;
        }
        finally
        {
            // Clean up
            if (conn != null)
            {
                conn.Close();
            }
        }
        cart.Items.Clear();
    }
}

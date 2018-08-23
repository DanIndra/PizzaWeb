using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;     // Needed for CS conversion
using System.Web.UI.WebControls;
using System.Web.UI;

partial class Default2 : System.Web.UI.Page
{
	protected void Page_Load(object sender, System.EventArgs e)
	{
		DataSet ds = new DataSet();
		// specify the two SQL statements required, first the Games table
		string sqlGames = "SELECT GameID, Title, Publisher, Rating, " + 
            "Released, Image FROM Games";
		// second SQL statement gets the columns required from the Consoles table
		string sqlConsoles = "SELECT fkGameID, Console, Price " + 
            "FROM Consoles INNER JOIN Games ON Games.GameID = Consoles.fkGameID " + 
            "ORDER BY Price DESC";

		// get conection string from Web.config file
        // string ConnectSQLshop = 
		string ConnectSQLshop = ConfigurationManager.ConnectionStrings
            ["CSConnectionString"].ConnectionString;

		// the Using statement ensures that the connection is closed automatically after use
		using (SqlConnection con = new SqlConnection(ConnectSQLshop)) {
			SqlDataAdapter da = new SqlDataAdapter(sqlGames, con);
			try {
				// fetch the Games rows into the DataSet as a new table
				da.Fill(ds, "Games");
				// change the SQL statement to select the Consoles
				da.SelectCommand.CommandText = sqlConsoles;
				// fetch the Consoles rows into the DataSet as another new table
				da.Fill(ds, "Consoles");
			} catch (Exception ex) {
				// if there is an error, display the message and stop execution here
				Label5.Text = "ERROR: " + ex.Message;
				return;
			}
		}

		// create a relationship between the two tables in the DataSet
		DataColumn pkcol = ds.Tables["Games"].Columns["GameID"];
		DataColumn fkcol = ds.Tables["Consoles"].Columns["fkGameID"];
		DataRelation dr = new DataRelation("GamesLink", pkcol, fkcol);
		ds.Relations.Add(dr);

		// bind the Games table to the DataList control to display the rows
		DataList1.DataSource = ds;
		DataList1.DataMember = "Games";
		DataList1.DataBind();
	}

	protected void DataList1_ItemDataBound(object sender, System.Web.UI.WebControls.DataListItemEventArgs e)
	{

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater rpt = (Repeater)e.Item.FindControl("Repeater1");
            HiddenField ItemID = new HiddenField();
            HiddenField ItemName = new HiddenField();

            ItemID.ID = "ItemID";
            ItemName.ID = "ItemName";

            ItemID.Value = DataBinder.Eval(e.Item.DataItem, "GameID").ToString();
            ItemName.Value = (string)DataBinder.Eval(e.Item.DataItem, "Title");

            rpt.Controls.Add(ItemID);
            rpt.Controls.Add(ItemName);
        }
	}

	protected void Repeater1_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
	{
        Repeater rpt = (Repeater)source;
		HiddenField IDControl = (HiddenField)rpt.FindControl("ItemID");
		HiddenField NameControl = (HiddenField)rpt.FindControl("ItemName");

		int GameID = Convert.ToInt32(IDControl.Value);
		string Title = NameControl.Value;
		string Console = e.CommandName.ToString();
		decimal Price = Convert.ToDecimal(e.CommandArgument);
		//uncomment the next line once the Cart Classes have been added
		StoredCart.InsertItem(GameID, Title, Console, 1, Price);
		Label5.Text = string.Format("{0} ({1}) added to the shopping cart", Title, Console);
	}
	public Default2()
	{
		Load += Page_Load;
	}
}

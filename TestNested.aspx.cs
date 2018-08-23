using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Web.UI.WebControls;

partial class Default2 : System.Web.UI.Page
{
    protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            SqlDataSource Link = (SqlDataSource)e.Row.FindControl("SqlDataSource2");
            Link.SelectParameters["fkGameID"].DefaultValue = GridView1.DataKeys[e.Row.RowIndex].Value.ToString();
        }
    }
}


/* *** VB Equivalent ***
Partial Class Default2
    Inherits System.Web.UI.Page


    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim Link As SqlDataSource = CType(e.Row.FindControl("SqlDataSource2"), SqlDataSource)
            Link.SelectParameters("fkGameID").DefaultValue = GridView1.DataKeys(e.Row.RowIndex).Value
        End If
    End Sub
End Class
 * */


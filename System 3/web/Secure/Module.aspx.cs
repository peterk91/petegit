using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Module : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        System.Data.SqlClient.SqlConnection MyConnection;
        System.Data.SqlClient.SqlCommand MyCommand;
        System.Data.SqlClient.SqlDataReader MyDataReader;
        MyConnection = new System.Data.SqlClient.SqlConnection("Data Source=co-web-3.lboro.ac.uk;Initial Catalog=team17;User ID=team17;Password=g6g88fcv");
        MyConnection.Open();
        MyCommand = new System.Data.SqlClient.SqlCommand();
        MyCommand.Connection = MyConnection;
        MyCommand.CommandText = "INSERT INTO Module (Name, ModuleID, DepartmentID, Part) VALUES ('" + ModuleName.Text + "','" + DepCode.Text + ModulePart.Text.Substring(0, 1) + ModuleCode.Text + "','" + DepCode.Text + "','" + ModulePart.Text + "')";
        MyDataReader = MyCommand.ExecuteReader();
        MyDataReader.Close();
        MyDataReader = null;
        Response.Redirect("~/Secure/modadd.aspx");
    }
}
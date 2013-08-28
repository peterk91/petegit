using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_view : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ModID = "";
        string RequestID = Request.Url.Query.ToString().Substring(1);
        Label11.Text = RequestID;
        System.Data.SqlClient.SqlConnection MyConnection;
        System.Data.SqlClient.SqlCommand MyCommand;
        System.Data.SqlClient.SqlDataReader MyDataReader;
        MyConnection = new System.Data.SqlClient.SqlConnection("Data Source=co-web-3.lboro.ac.uk;Initial Catalog=team17;User ID=team17;Password=g6g88fcv");
        MyConnection.Open();
        MyCommand = new System.Data.SqlClient.SqlCommand();
        MyCommand.Connection = MyConnection;
        MyCommand.CommandText = "SELECT ModuleID,NoStudents,ParkOnly,BuildingID, Status FROM Request WHERE (RequestID = " + RequestID + ")";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            Label1.Text = MyDataReader.GetSqlValue(0).ToString();
            ModID = MyDataReader.GetSqlValue(0).ToString();
            Label9.Text = MyDataReader.GetSqlValue(1).ToString();
            Label10.Text = MyDataReader.GetSqlValue(4).ToString();
            if (MyDataReader.GetSqlValue(2).ToString() == "Null")
            {
                Label5.Text = "Any";
            }
            else
            {
                Label5.Text = MyDataReader.GetSqlValue(2).ToString();
            }
            if (MyDataReader.GetSqlValue(3).ToString() == "Null")
            {
                Label6.Text = "Any";
            }
            else
            {
                Label6.Text = MyDataReader.GetSqlValue(3).ToString();
            }
        }
        MyDataReader.Close();
        MyDataReader = null;



        MyCommand.CommandText = "SELECT Name FROM Module WHERE (ModuleID = '" + ModID + "')";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            Label2.Text = MyDataReader.GetSqlValue(0).ToString();
        }
        MyDataReader.Close();
        MyDataReader = null;


            MyCommand.CommandText = "SELECT team17.Function3("+ RequestID + ")";
            MyDataReader = MyCommand.ExecuteReader();
            while (MyDataReader.Read())
            {
                    Label8.Text = MyDataReader.GetSqlValue(0).ToString();
        
            }
            MyDataReader.Close();
            MyDataReader = null;



        MyCommand.CommandText = "SELECT team17.ConcatRooms(" + RequestID + ")";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            if (MyDataReader.GetSqlValue(0).ToString() != "Null")
            {
                Label3.Text = MyDataReader.GetSqlValue(0).ToString();
            }
            else
            {
                Label3.Text = "Any";
            }
        }
        MyDataReader.Close();
        MyDataReader = null;


        MyCommand.CommandText = "SELECT team17.ConcatTimes("+RequestID+",0,8,-1)";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            if (MyDataReader.GetSqlValue(0).ToString() != "Null")
            {
                Label7.Text += "Mon - Period " + MyDataReader.GetSqlValue(0).ToString() + ", ";
            }
        }
        MyDataReader.Close();
        MyDataReader = null;

        MyCommand.CommandText = "SELECT team17.ConcatTimes(" + RequestID + ",9,17,8)";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            if (MyDataReader.GetSqlValue(0).ToString() != "Null")
            {
                Label7.Text += "Tue - Period " + MyDataReader.GetSqlValue(0).ToString() + ", ";
            }
        }
        MyDataReader.Close();
        MyDataReader = null;


        MyCommand.CommandText = "SELECT team17.ConcatTimes(" + RequestID + ",18,26,17)";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            if (MyDataReader.GetSqlValue(0).ToString() != "Null")
            {
                Label7.Text += "Wed - Period " + MyDataReader.GetSqlValue(0).ToString() + ", ";
            }
        }
        MyDataReader.Close();
        MyDataReader = null;

        MyCommand.CommandText = "SELECT team17.ConcatTimes(" + RequestID + ",27,35,26)";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            if (MyDataReader.GetSqlValue(0).ToString() != "Null")
            {
                Label7.Text += "Thurs - Period " + MyDataReader.GetSqlValue(0).ToString() + ", ";
            }
        }
        MyDataReader.Close();
        MyDataReader = null;

        MyCommand.CommandText = "SELECT team17.ConcatTimes(" + RequestID + ",36,44,35)";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            if (MyDataReader.GetSqlValue(0).ToString() != "Null")
            {
                Label7.Text += "Fri - Period " + MyDataReader.GetSqlValue(0).ToString() + ", ";
            }
        }
        MyDataReader.Close();
        MyDataReader = null;

        int written1 = 0;
        int written2 = 0;
        MyCommand.CommandText = "SELECT Name FROM Facility WHERE FacilityID IN(SELECT FacilityID FROM RequestFacility WHERE (RequestID =" + RequestID + ") AND (FacilityID < 3))";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            if (MyDataReader.GetSqlValue(0).ToString() != "Null")
            {
                Label12.Text = MyDataReader.GetSqlValue(0).ToString();
                written1 = 1;
            }
        }
        MyDataReader.Close();
        MyDataReader = null;
        if (written1 == 0)
            {
                Label12.Text = "Any";
            }

        MyCommand.CommandText = "SELECT Name FROM Facility WHERE FacilityID IN(SELECT FacilityID FROM RequestFacility WHERE (RequestID =" + RequestID + ") AND (FacilityID > 2) AND (FacilityID < 5))";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            if (MyDataReader.GetSqlValue(0).ToString() != "Null")
            {
                Label13.Text = MyDataReader.GetSqlValue(0).ToString();
                written2 = 1;
            }

        }
        MyDataReader.Close();
        MyDataReader = null;
        if (written2 == 0)
            {
                Label13.Text = "Any";
            }

        MyCommand.CommandText = "SELECT team17.Function4(" + RequestID + ")";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            if (MyDataReader.GetSqlValue(0).ToString() != "Null")
            {
                Label4.Text += MyDataReader.GetSqlValue(0).ToString();
            }
            else
            {
                Label4.Text += "None";
            }
        }
        MyDataReader.Close();
        MyDataReader = null;

        MyCommand.CommandText = "SELECT DISTINCT TimeID FROM RequestTime WHERE (RequestID = "+RequestID+") ";

        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            for (int a = 0; a < 45; a++)
            {
                if (MyDataReader.GetSqlValue(0).ToString() == a.ToString())
                {
                    if (a < 9)
                    {
                        Table1.Rows[2].Cells[a + 1].BackColor = System.Drawing.Color.Red;
                    }

                    if (a > 8 && a < 18)
                    {
                        int b = (a - 9);
                        Table1.Rows[3].Cells[b + 1].BackColor = System.Drawing.Color.Red;

                    }

                    if (a > 17 && a < 27)
                    {
                        int b = (a - 18);
                        Table1.Rows[4].Cells[b + 1].BackColor = System.Drawing.Color.Red;
                    }

                    if (a > 26 && a < 36)
                    {
                        int b = (a - 27);
                        Table1.Rows[5].Cells[b + 1].BackColor = System.Drawing.Color.Red;
                    }

                    if (a > 35 && a < 45)
                    {
                        int b = (a - 36);
                        Table1.Rows[6].Cells[b + 1].BackColor = System.Drawing.Color.Red;
                    }

                }
            }
        }
        MyDataReader.Close();
        MyDataReader = null;

  

    }
}
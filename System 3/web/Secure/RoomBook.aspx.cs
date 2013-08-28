using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_RoomBook : System.Web.UI.Page
{

    protected void rounddec()
    {
        System.Data.SqlClient.SqlConnection MyConnection;
        System.Data.SqlClient.SqlCommand MyCommand;
        System.Data.SqlClient.SqlDataReader MyDataReader;
        MyConnection = new System.Data.SqlClient.SqlConnection("Data Source=co-web-3.lboro.ac.uk;Initial Catalog=team17;User ID=team17;Password=g6g88fcv");
        MyConnection.Open();
        MyCommand = new System.Data.SqlClient.SqlCommand();
        MyCommand.Connection = MyConnection;
        MyCommand.CommandText = "SELECT Round FROM Round WHERE (RoundID = '" + DropDownList3.SelectedValue + "')";
        MyDataReader = MyCommand.ExecuteReader();
        string roundname = "";
        while (MyDataReader.Read())
        {
            roundname = MyDataReader.GetSqlValue(0).ToString();
        }
        MyDataReader.Close();
        MyDataReader = null;

        if (roundname == "Ad hoc")
        {
            Label1.Text = "You are booking in Ad hoc mode, your request will be instantly allocated";
            Button1.Text = "Submit Instant Request";
            RadioButtonList2.Visible = false;
            RadioButtonList2.Items[1].Selected = true;
            CheckBoxList1.Enabled = true;
            CheckBoxList1.Items[0].Enabled = false;
            CheckBoxList1.Items[0].Selected = false;
            CheckBoxList1.Items[1].Enabled = false;
            CheckBoxList1.Items[1].Selected = false;
            CheckBoxList1.Items[2].Enabled = false;
            CheckBoxList1.Items[2].Selected = false;
            CheckBoxList1.Items[3].Enabled = false;
            CheckBoxList1.Items[3].Selected = false;
            CheckBoxList1.Items[4].Enabled = false;
            CheckBoxList1.Items[4].Selected = false;
            CheckBoxList1.Items[5].Enabled = false;
            CheckBoxList1.Items[5].Selected = false;
            CheckBoxList1.Items[6].Enabled = false;
            CheckBoxList1.Items[6].Selected = false;
            CheckBoxList1.Items[7].Enabled = false;
            CheckBoxList1.Items[7].Selected = false;
            CheckBoxList1.Items[8].Enabled = false;
            CheckBoxList1.Items[8].Selected = false;
            CheckBoxList1.Items[9].Enabled = false;
            CheckBoxList1.Items[9].Selected = false;
            CheckBoxList1.Items[10].Selected = false;
            CheckBoxList1.Items[11].Selected = false;
            CheckBoxList1.Items[12].Selected = false;
        }
        else
        {
            RadioButtonList2.Visible = true;
            CheckBoxList1.Enabled = false;
            CheckBoxList1.Items[0].Enabled = true;
            CheckBoxList1.Items[1].Enabled = true;
            CheckBoxList1.Items[2].Enabled = true;
            CheckBoxList1.Items[3].Enabled = true;
            CheckBoxList1.Items[4].Enabled = true;
            CheckBoxList1.Items[5].Enabled = true;
            CheckBoxList1.Items[6].Enabled = true;
            CheckBoxList1.Items[7].Enabled = true;
            CheckBoxList1.Items[8].Enabled = true;
            CheckBoxList1.Items[9].Enabled = true;
            RadioButtonList2.SelectedValue = "All";
            CheckBoxList1.Items[0].Selected = true;
            CheckBoxList1.Items[1].Selected = true;
            CheckBoxList1.Items[2].Selected = true;
            CheckBoxList1.Items[3].Selected = true;
            CheckBoxList1.Items[4].Selected = true;
            CheckBoxList1.Items[5].Selected = true;
            CheckBoxList1.Items[6].Selected = true;
            CheckBoxList1.Items[7].Selected = true;
            CheckBoxList1.Items[8].Selected = true;
            CheckBoxList1.Items[9].Selected = true;
            CheckBoxList1.Items[10].Selected = true;
            CheckBoxList1.Items[11].Selected = false;
            CheckBoxList1.Items[12].Selected = false;
            CheckBoxList1.Items[13].Selected = false;
            CheckBoxList1.Items[14].Selected = false;
            Label1.Text = "";
            Button1.Text = "Submit Request";
        }
        updatetimes();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string RoomID = Request.Url.Query.ToString().Substring(1);
        Label2.Text = RoomID;

        System.Data.SqlClient.SqlConnection MyConnection;
        System.Data.SqlClient.SqlCommand MyCommand;
        System.Data.SqlClient.SqlDataReader MyDataReader;
        MyConnection = new System.Data.SqlClient.SqlConnection("Data Source=co-web-3.lboro.ac.uk;Initial Catalog=team17;User ID=team17;Password=g6g88fcv");
        MyConnection.Open();
        MyCommand = new System.Data.SqlClient.SqlCommand();
        MyCommand.Connection = MyConnection;
        MyCommand.CommandText = "SELECT Capacity FROM Room WHERE RoomID = '"+RoomID+"' ";
        MyDataReader = MyCommand.ExecuteReader();
        string nocap = "";
        while (MyDataReader.Read())
        {
            nocap = MyDataReader.GetSqlValue(0).ToString();
        }
        MyDataReader.Close();
        MyDataReader = null;
        Label3.Text = nocap;
        NoStudentsValidation.MaximumValue = nocap;
        NoStudentsValidation.ErrorMessage = "Number of Students must be between 1 and "+nocap + ".";





    }


    protected void updatetimes()
    {
        string Roomid = Label2.Text;
        System.Data.SqlClient.SqlConnection MyConnection;
        System.Data.SqlClient.SqlCommand MyCommand;
        System.Data.SqlClient.SqlDataReader MyDataReader;
        MyConnection = new System.Data.SqlClient.SqlConnection("Data Source=co-web-3.lboro.ac.uk;Initial Catalog=team17;User ID=team17;Password=g6g88fcv");
        MyConnection.Open();
        MyCommand = new System.Data.SqlClient.SqlCommand();
        MyCommand.Connection = MyConnection;

        for (int a = 0; a < 45; a++)
        {
                CheckBoxList2.Items[a].Enabled = true;
        }

        string Command1 = "";
        int count = 0;
            Command1 = "SELECT DISTINCT TimeID FROM RequestTime WHERE (RequestID IN(SELECT RequestID FROM Request WHERE (Status = 'Allocated') AND (RoundID IN(SELECT RoundID FROM Round WHERE SemesterID =(SELECT SemesterID FROM Round WHERE RoundID='" + DropDownList3.SelectedValue + "'))))) AND RequestID IN(SELECT RequestID FROM RequestRoom WHERE RoomID = '" + Label2.Text + "')";
            
            for (int r = 0; r < 15; r++)
            {
                if (CheckBoxList1.Items[r].Selected == true && count==0)
                {
                    count++;
                    Command1 += "AND ((Week = "+(r+1)+")";
                }

                if (CheckBoxList1.Items[r].Selected == true && count > 0)
                {
                    count++;
                    Command1 += "OR (Week = " + (r + 1) + ")";
                }
            }
            if (count > 0)
                Command1 += ")";

               
        MyCommand.CommandText = Command1;
                if(count!=0)
            {
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            for (int a = 0; a < 45; a++)
            {
                if (MyDataReader.GetSqlValue(0).ToString() == a.ToString())
                {
                    CheckBoxList2.Items[a].Selected = false;
                    CheckBoxList2.Items[a].Enabled = false;
                }
            }
        }
        MyDataReader.Close();
        MyDataReader = null;
            }

        
    }

    protected void ListBox1_SelectedIndexChanged1(object sender, EventArgs e)
    {
        ListBoxModNames.SelectedValue = ListBoxModCodes.SelectedValue;
    }
    protected void ListBox2_SelectedIndexChanged(object sender, EventArgs e)
    {
        ListBoxModCodes.SelectedValue = ListBoxModNames.SelectedValue;
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedItem.Text != "All")
        {
            SQLModCodes.SelectCommand = "SELECT * FROM Module WHERE (Part = '" + DropDownList1.SelectedValue + "') AND DepartmentID='" + Session["login_name"] + "' ORDER BY ModuleID";
            SQLModNames.SelectCommand = "SELECT * FROM Module WHERE (Part = '" + DropDownList1.SelectedValue + "') AND DepartmentID='" + Session["login_name"] + "' ORDER BY Name";
        }
        else
        {
            SQLModCodes.SelectCommand = "SELECT * FROM Module WHERE DepartmentID='" + Session["login_name"] + "' ORDER BY ModuleID";
            SQLModNames.SelectCommand = "SELECT * FROM Module WHERE DepartmentID='" + Session["login_name"] + "' ORDER BY Name";
        }
    }


    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
        DropDownList1.Items.Insert(0, "All");
        DropDownList1.SelectedIndex = 0;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string status = "";
        if (Button1.Text == "Submit Instant Request")
        {
            status = "Allocated";
        }

        if (Button1.Text == "Submit Request")
        {
            status = "Pending";
        }

        string insertstring = "INSERT INTO Request (ModuleID, RoundID, UserID, NoStudents, Status, NoRooms) VALUES('" + ListBoxModCodes.SelectedItem.Text + "'," + DropDownList3.SelectedValue + ",@UserID," + TextBoxStudents.Text + ",'" + status + "',1) ";
        InsertNewBooking.InsertCommand = insertstring;
        InsertNewBooking.Insert();
        System.Data.SqlClient.SqlConnection MyConnection;
        System.Data.SqlClient.SqlCommand MyCommand;
        System.Data.SqlClient.SqlDataReader MyDataReader;
        MyConnection = new System.Data.SqlClient.SqlConnection("Data Source=co-web-3.lboro.ac.uk;Initial Catalog=team17;User ID=team17;Password=g6g88fcv");
        MyConnection.Open();
        MyCommand = new System.Data.SqlClient.SqlCommand();
        MyCommand.Connection = MyConnection;
        MyCommand.CommandText = "SELECT RequestID FROM REQUEST";
        MyDataReader = MyCommand.ExecuteReader();
        string reqID = "";
        while (MyDataReader.Read())
        {
            reqID = MyDataReader.GetSqlValue(0).ToString();
        }
        MyDataReader.Close();
        MyDataReader = null;

                MyCommand.CommandText = "INSERT INTO RequestRoom (RequestID, RoomID) VALUES('" + reqID + "', '" + Label2.Text + "')";
                MyDataReader = MyCommand.ExecuteReader();
                MyDataReader.Close();
                MyDataReader = null;

                for (int z = 0; z < CheckBoxList1.Items.Count; z++)
                {
                    if (CheckBoxList1.Items[z].Selected == true)
                    {
                        for (int b = 0; b < CheckBoxList2.Items.Count; b++)
                        {
                            if (CheckBoxList2.Items[b].Selected == true)
                            {
                                MyCommand.CommandText = "INSERT INTO RequestTime (RequestID, Week, TimeID) VALUES(" + reqID + ", " + (z + 1) + ", " + b + ") ";
                                MyDataReader = MyCommand.ExecuteReader();
                                MyDataReader.Close();
                                MyDataReader = null;
                            }
                        }
                    }
                }
        MyCommand = null;
        MyConnection.Close();
        MyConnection = null;
        Response.Redirect("~/Secure/booked.aspx?"+reqID);
    }

    protected void RadioButtonList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RadioButtonList2.SelectedValue == "All")
        {
            CheckBoxList1.Enabled = false;
            CheckBoxList1.Items[0].Selected = true;
            CheckBoxList1.Items[1].Selected = true;
            CheckBoxList1.Items[2].Selected = true;
            CheckBoxList1.Items[3].Selected = true;
            CheckBoxList1.Items[4].Selected = true;
            CheckBoxList1.Items[5].Selected = true;
            CheckBoxList1.Items[6].Selected = true;
            CheckBoxList1.Items[7].Selected = true;
            CheckBoxList1.Items[8].Selected = true;
            CheckBoxList1.Items[9].Selected = true;
            CheckBoxList1.Items[10].Selected = true;
            CheckBoxList1.Items[11].Selected = true;
            CheckBoxList1.Items[12].Selected = false;
            CheckBoxList1.Items[13].Selected = false;
            CheckBoxList1.Items[14].Selected = false;
        }
        else
        {
            CheckBoxList1.Enabled = true;
            CheckBoxList1.Items[0].Selected = false;
            CheckBoxList1.Items[1].Selected = false;
            CheckBoxList1.Items[2].Selected = false;
            CheckBoxList1.Items[3].Selected = false;
            CheckBoxList1.Items[4].Selected = false;
            CheckBoxList1.Items[5].Selected = false;
            CheckBoxList1.Items[6].Selected = false;
            CheckBoxList1.Items[7].Selected = false;
            CheckBoxList1.Items[8].Selected = false;
            CheckBoxList1.Items[9].Selected = false;
            CheckBoxList1.Items[10].Selected = false;
            CheckBoxList1.Items[11].Selected = false;
            CheckBoxList1.Items[12].Selected = false;
            CheckBoxList1.Items[13].Selected = false;
            CheckBoxList1.Items[14].Selected = false;
        }
        updatetimes();
    }

    protected void DropDownList3_DataBound(object sender, EventArgs e)
    {
        rounddec();
    }
    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {
        rounddec();
    }
    protected void TextBoxStudents_TextChanged(object sender, EventArgs e)
    {

    }
    protected void CheckBoxList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        updatetimes();
    }
    protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        updatetimes();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Secure/booking.aspx");
    }
    protected void CheckBoxList2_Unload(object sender, EventArgs e)
    {
        updatetimes();
    }
}
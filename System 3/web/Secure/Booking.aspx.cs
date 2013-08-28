using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Booking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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

    protected void UpdateRoomSQL()
    {
        var RoomSQL = "SELECT DISTINCT RoomID FROM Room WHERE (RoomID != '')";
        if (DropDownListRoomStyle.SelectedItem.Text == "All")
        {
        }
        else
        {
            RoomSQL = RoomSQL + " AND (RoomID IN(SELECT RoomID FROM RoomFacility WHERE (FacilityID='"+DropDownListRoomStyle.SelectedValue+"'))) ";
        }

        if (DropDownListRoomType.SelectedItem.Text == "All")
        {
        }
        else
        {
            RoomSQL = RoomSQL + " AND (RoomID IN(SELECT RoomID FROM RoomFacility WHERE (FacilityID='" + DropDownListRoomType.SelectedValue + "'))) ";
        }

        if (DropDownList4.SelectedValue == "All")
        {
            if (DropDownListPark.SelectedItem.Text == "All")
            {
            }
            else
            {
                RoomSQL = RoomSQL + " AND (RoomID IN(SELECT RoomID FROM Room WHERE (BuildingID IN(SELECT BuildingID FROM Building WHERE (Park = '" + DropDownListPark.SelectedValue + "'))))) ";
            }
        }
        else
        {
            RoomSQL = RoomSQL + " AND (RoomID IN(Select RoomID FROM Room WHERE (BuildingID = '"+DropDownList4.SelectedValue+"')))";
        }
        for (int i = 0; i < CheckBoxListFacilities.Items.Count; i++)
        {
            if (CheckBoxListFacilities.Items[i].Selected)
            {
                RoomSQL = RoomSQL + " AND (RoomID IN(Select RoomID FROM RoomFacility WHERE (FacilityID = '" + CheckBoxListFacilities.Items[i].Value + "' ))) ";
            }
        }

        if (TextBoxStudents.Text != "")
        {
            if (DropDownList2.SelectedValue == "1")
            {
                RoomSQL = RoomSQL + " AND (Capacity >='" + TextBoxStudents.Text + "') ";
            }
            if (DropDownList2.SelectedValue == "2")
            {
                RoomSQL = RoomSQL + " AND (Capacity >='" + (int.Parse(TextBoxStudents.Text)/2) + "') ";
            }
            if (DropDownList2.SelectedValue == "3")
            {
                RoomSQL = RoomSQL + " AND (Capacity >='" + int.Parse(TextBoxStudents.Text) / 3 + "') ";
            }
            if (DropDownList2.SelectedValue == "4")
            {
                RoomSQL = RoomSQL + " AND (Capacity >='" + int.Parse(TextBoxStudents.Text) / 4 + "') ";
            }
            
        }

        for (int z = 0; z < CheckBoxList1.Items.Count; z++)
        {
            if (CheckBoxList1.Items[z].Selected == true)
            {
                for (int b = 0; b < CheckBoxList2.Items.Count; b++)
                {
                    if (CheckBoxList2.Items[b].Selected == true)
                    {
                        RoomSQL = RoomSQL + " AND (RoomID NOT IN(SELECT RoomID FROM RequestRoom WHERE RequestID IN(SELECT RequestID FROM RequestTime WHERE (TimeID = "+b+") AND (Week = "+(z+1)+" )) AND RequestID IN(SELECT RequestID From Request WHERE Status = 'Allocated' AND RoundID IN(SELECT RoundID FROM Round WHERE SemesterID =(SELECT SemesterID FROM Round WHERE RoundID="+DropDownList3.SelectedValue+")))))";
                    }
                }
            }
        }



        SQLRooms.SelectCommand = RoomSQL;
      }

    protected void DropDownListRoomType_DataBound(object sender, EventArgs e)
    {
        DropDownListRoomType.Items.Insert(0, "All");
        DropDownListRoomType.SelectedIndex = 0;
    }

    protected void DropDownListRoomStyle_DataBound(object sender, EventArgs e)
    {
        DropDownListRoomStyle.Items.Insert(0, "All");
        DropDownListRoomStyle.SelectedIndex = 0;
    }
    protected void DropDownListPark_DataBound(object sender, EventArgs e)
    {
        DropDownListPark.Items.Insert(0, "All");
        DropDownListPark.SelectedIndex = 0;
    }

    protected void DropDownList2_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (DropDownList2.SelectedValue == "1")
        {
            RoomBox1.Visible = true;
            RoomBox4.Visible = false;
            RoomBox2.Visible = false;
            RoomBox3.Visible = false;
        }
        if (DropDownList2.SelectedValue == "2")
        {
            RoomBox1.Visible = true;
            RoomBox4.Visible = true;
            RoomBox2.Visible = false;
            RoomBox3.Visible = false;
        }
        if (DropDownList2.SelectedValue == "3")
        {
            RoomBox1.Visible = true;
            RoomBox4.Visible = true;
            RoomBox2.Visible = true;
            RoomBox3.Visible = false;
        }
        if (DropDownList2.SelectedValue == "4")
        {
            RoomBox1.Visible = true;
            RoomBox4.Visible = true;
            RoomBox2.Visible = true;
            RoomBox3.Visible = true;
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string status = "";
        if(Button1.Text == "Submit Instant Request")
        {
            status = "Allocated";
        }

        if(Button1.Text == "Submit Request")
        {
            status = "Pending";
        }

        string insertstring =  "INSERT INTO Request (ModuleID, RoundID, UserID, NoStudents, Status, ParkOnly, BuildingID, NoRooms) VALUES('" + ListBoxModCodes.SelectedItem.Text + "'," + DropDownList3.SelectedValue + ",@UserID," + TextBoxStudents.Text + ",'"+status+"',";

        if (DropDownListPark.SelectedItem.Text == "All" || RoomBox1.SelectedIndex != -1)
        {
            insertstring += "null,";
        }
        else
        {
            insertstring += "'"+DropDownListPark.SelectedItem.Text+"',";
        }
        if (DropDownList4.SelectedItem.Text == "All" || RoomBox1.SelectedIndex != -1)
        {
            insertstring += "null,";
        }
        else
        {
            insertstring += "'" + DropDownList4.SelectedValue+"',";
        }
        insertstring += " " + DropDownList2.SelectedValue + ")";

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

        for (int d = 0; d <= DropDownList2.SelectedIndex; d++)
        {
            if (d == 0 && RoomBox1.SelectedIndex != -1)
            {
                MyCommand.CommandText = "INSERT INTO RequestRoom (RequestID, RoomID) VALUES('" + reqID + "', '" + RoomBox1.SelectedValue + "')";
                MyDataReader = MyCommand.ExecuteReader();
                MyDataReader.Close();
                MyDataReader = null;
            }

            if (d == 1 && RoomBox2.SelectedIndex != -1)
            {
                MyCommand.CommandText = "INSERT INTO RequestRoom (RequestID, RoomID) VALUES('" + reqID + "', '" + RoomBox2.SelectedValue + "')";
                MyDataReader = MyCommand.ExecuteReader();
                MyDataReader.Close();
                MyDataReader = null;
            }

            if (d == 2 && RoomBox3.SelectedIndex != -1)
            {
                MyCommand.CommandText = "INSERT INTO RequestRoom (RequestID, RoomID) VALUES('" + reqID + "', '" + RoomBox3.SelectedValue + "')";
                MyDataReader = MyCommand.ExecuteReader();
                MyDataReader.Close();
                MyDataReader = null;
            }

            if (d == 3 && RoomBox4.SelectedIndex != -1)
            {
                MyCommand.CommandText = "INSERT INTO RequestRoom (RequestID, RoomID) VALUES('" + reqID + "', '" + RoomBox4.SelectedValue + "')";
                MyDataReader = MyCommand.ExecuteReader();
                MyDataReader.Close();
                MyDataReader = null;
            }
        }

        if(DropDownListRoomType.SelectedValue != "All")
        {
        MyCommand.CommandText = "INSERT INTO RequestFacility (RequestID, FacilityID) VALUES(" + reqID + ", " + DropDownListRoomType.SelectedValue + ") ";
        MyDataReader = MyCommand.ExecuteReader();
        MyDataReader.Close();
        MyDataReader = null;
        }

        if (DropDownListRoomStyle.SelectedValue != "All")
        {
            MyCommand.CommandText = "INSERT INTO RequestFacility (RequestID, FacilityID) VALUES(" + reqID + ", " + (DropDownListRoomStyle.SelectedValue + 3) + ") ";
            MyDataReader = MyCommand.ExecuteReader();
            MyDataReader.Close();
            MyDataReader = null;
        }

        int noFacilities = CheckBoxListFacilities.Items.Count;
        for (int x = 0; x < noFacilities; x++)
        {
            if (CheckBoxListFacilities.Items[x].Selected == true)
            {
                MyCommand.CommandText = "INSERT INTO RequestFacility (RequestID, FacilityID) VALUES(" + reqID + ", "+(x+5)+") ";
                MyDataReader = MyCommand.ExecuteReader();
                MyDataReader.Close();
                MyDataReader = null;
            }

        }


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
        Response.Redirect("~/Secure/booked.aspx?"+(reqID));
    }

    protected void RadioButtonList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(RadioButtonList2.SelectedValue == "All")
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
        UpdateRoomSQL();
    }


    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList2.SelectedIndex == 0)
        {
            RoomBox1.Visible = true;
            RoomBox2.Visible = false;
            RoomBox3.Visible = false;
            RoomBox4.Visible = false;
        }
        if (DropDownList2.SelectedIndex == 1)
        {
            RoomBox1.Visible = true;
            RoomBox2.Visible = true;
            RoomBox3.Visible = false;
            RoomBox4.Visible = false;
        }
        if (DropDownList2.SelectedIndex == 2)
        {
            RoomBox1.Visible = true;
            RoomBox2.Visible = true;
            RoomBox3.Visible = true;
            RoomBox4.Visible = false;
        }
        if (DropDownList2.SelectedIndex == 3)
        {
            RoomBox1.Visible = true;
            RoomBox2.Visible = true;
            RoomBox3.Visible = true;
            RoomBox4.Visible = true;
        }
        UpdateRoomSQL();
        
    }



    protected void rounddec()
    {
        System.Data.SqlClient.SqlConnection MyConnection;
        System.Data.SqlClient.SqlCommand MyCommand;
        System.Data.SqlClient.SqlDataReader MyDataReader;
        MyConnection = new System.Data.SqlClient.SqlConnection("Data Source=co-web-3.lboro.ac.uk;Initial Catalog=team17;User ID=team17;Password=g6g88fcv");
        MyConnection.Open();
        MyCommand = new System.Data.SqlClient.SqlCommand();
        MyCommand.Connection = MyConnection;
        MyCommand.CommandText = "SELECT Round FROM Round WHERE (RoundID = '"+DropDownList3.SelectedValue+"')";
        MyDataReader = MyCommand.ExecuteReader();
        string roundname = "";
        while (MyDataReader.Read())
        {
            roundname = MyDataReader.GetSqlValue(0).ToString();
        }
        MyDataReader.Close();
        MyDataReader = null;

        if(roundname == "Ad hoc")
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
    }


    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {
        rounddec();
        UpdateRoomSQL();
    }
    protected void DropDownListPark_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(DropDownListPark.SelectedItem.Text != "All")
        {
            SqlBuildings.SelectCommand = "SELECT * From Building WHERE (Park = '" + DropDownListPark.SelectedItem.Text + "')";
        }
        else
        {
            SqlBuildings.SelectCommand = "SELECT * From Building";
        }
        DropDownList4.SelectedIndex = 0;
        UpdateRoomSQL();
    }
    protected void DropDownList4_DataBound(object sender, EventArgs e)
    {
        DropDownList4.Items.Insert(0, "All");
        DropDownList4.SelectedIndex = 0;
    }
    protected void CheckBoxListFacilities_SelectedIndexChanged(object sender, EventArgs e)
    {
        UpdateRoomSQL();
    }
    protected void DropDownListRoomType_SelectedIndexChanged(object sender, EventArgs e)
    {
        UpdateRoomSQL();
    }
    protected void DropDownListRoomStyle_SelectedIndexChanged(object sender, EventArgs e)
    {
        UpdateRoomSQL();
    }
    protected void DropDownList4_SelectedIndexChanged(object sender, EventArgs e)
    {
        UpdateRoomSQL();
    }
    protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        UpdateRoomSQL();
    }
    protected void CheckBoxList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        UpdateRoomSQL();
    }
    protected void TextBoxStudents_TextChanged(object sender, EventArgs e)
    {
        UpdateRoomSQL();
    }
    protected void DropDownList3_DataBound(object sender, EventArgs e)
    {
        rounddec();
    }
}
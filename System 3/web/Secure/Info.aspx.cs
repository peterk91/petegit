using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Info : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ListBox3_SelectedIndexChanged(object sender, EventArgs e)
    {
        ListBoxBuildID.SelectedValue = ListBoxBuildNames.SelectedValue;
        RoomCodes.SelectCommand = "SELECT * FROM Room WHERE (BuildingID='" + ListBoxBuildNames.SelectedValue + "')";
        InfoPanel.Visible = false;
    }
    protected void ListBox2_SelectedIndexChanged(object sender, EventArgs e)
    {
        ListBoxBuildNames.SelectedValue = ListBoxBuildID.SelectedValue;
        RoomCodes.SelectCommand = "SELECT * FROM Room WHERE (BuildingID='" + ListBoxBuildID.SelectedValue + "')";
        InfoPanel.Visible = false;
    }
    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ListBoxPark.SelectedValue == "All")
        {
            BuildingCodes.SelectCommand = "SELECT * FROM Building";
            BuildingNames.SelectCommand = "SELECT * FROM Building ORDER BY Name";
            RoomCodes.SelectCommand = "SELECT [Name] FROM [Building] WHERE (BuildingID = 'Nothing')";
        }
        else
        {
            BuildingCodes.SelectCommand = "SELECT * FROM Building WHERE (Park='" + ListBoxPark.SelectedValue + "')";
            BuildingNames.SelectCommand = "SELECT * FROM Building WHERE (Park='" + ListBoxPark.SelectedValue + "') ORDER BY Name";
            RoomCodes.SelectCommand = "SELECT [Name] FROM [Building] WHERE (BuildingID = 'Nothing')";
        }
        InfoPanel.Visible = false;
    }
    protected void ListBox1_DataBound(object sender, EventArgs e)
    {
        ListBoxPark.Items.Insert(0, "All");
        ListBoxPark.SelectedIndex = 0;
    }



    protected void RadioButtonList1_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (RadioButtonFilter.Text == "On")
        {
            BuildingCodes.SelectCommand = "SELECT * FROM Building";
            BuildingNames.SelectCommand = "SELECT * FROM Building ORDER BY Name";
            UpdateRoomSQL();
            ListBoxPark.SelectedIndex = -1;
            ListBoxBuildNames.SelectedIndex = -1;
            ListBoxBuildID.SelectedIndex = -1;
            ListBoxRooms.SelectedIndex = -1;
            ListBoxBuildID.ForeColor = System.Drawing.Color.LightGray;
            ListBoxBuildNames.ForeColor = System.Drawing.Color.LightGray;
            ListBoxPark.ForeColor = System.Drawing.Color.LightGray;
            ListBoxBuildNames.Enabled = false;
            ListBoxBuildID.Enabled = false;
            ListBoxPark.Enabled = false;
            DropDownListStyle.Enabled = true;
            DropDownListType.Enabled = true;
            TextBoxCapacity.Enabled = true;
            CheckBoxListFacilities.Enabled = true;


        }
        else
        {
            ListBoxBuildID.ForeColor = System.Drawing.Color.Black;
            ListBoxBuildNames.ForeColor = System.Drawing.Color.Black;
            ListBoxPark.ForeColor = System.Drawing.Color.Black;
            Facilities.SelectCommand = "SELECT * FROM [Facility] WHERE (FacilityID > 4)";
            ListBoxBuildNames.Enabled = true;
            ListBoxBuildID.Enabled = true;
            ListBoxPark.Enabled = true;
            DropDownListStyle.Enabled = false;
            DropDownListType.Enabled = false;
            TextBoxCapacity.Enabled = false;
            CheckBoxListFacilities.Enabled = false;
            ListBoxPark.SelectedIndex = -1;
            ListBoxBuildNames.SelectedIndex = -1;
            ListBoxBuildID.SelectedIndex = -1;
            ListBoxRooms.SelectedIndex = -1;
            DropDownListStyle.SelectedIndex = 0;
            DropDownListType.SelectedIndex = 0;
        }
        InfoPanel.Visible = false;

    }


    protected void ListBox4_SelectedIndexChanged(object sender, EventArgs e)
    {
        InfoPanel.Visible = true;
        string BuildingID = "";
        string RoomID = ListBoxRooms.SelectedItem.Text;

        System.Data.SqlClient.SqlConnection MyConnection;
        System.Data.SqlClient.SqlCommand MyCommand;
        System.Data.SqlClient.SqlDataReader MyDataReader;
        MyConnection = new System.Data.SqlClient.SqlConnection("Data Source=co-web-3.lboro.ac.uk;Initial Catalog=team17;User ID=team17;Password=g6g88fcv");
        MyConnection.Open();
        MyCommand = new System.Data.SqlClient.SqlCommand();
        MyCommand.Connection = MyConnection;
        MyCommand.CommandText = "SELECT * FROM Room WHERE (RoomID = '"+RoomID+"')";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            Label8.Text = MyDataReader.GetSqlValue(0).ToString();
            BuildingID = MyDataReader.GetSqlValue(1).ToString();
            Label11.Text = MyDataReader.GetSqlValue(2).ToString();
            ImageRoom.ImageUrl = "http://www.lboro.ac.uk/service/fm/services/ts/roompics/" + MyDataReader.GetSqlValue(3).ToString();
        }
        MyDataReader.Close();
        MyDataReader = null;

        MyCommand.CommandText = "SELECT * FROM Building WHERE (BuildingID = '"+BuildingID+"')";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            Label9.Text = MyDataReader.GetSqlValue(0).ToString();
            Label10.Text = MyDataReader.GetSqlValue(2).ToString();
        }
        MyDataReader.Close();
        MyDataReader = null;

        MyCommand.CommandText = "SELECT * FROM RoomFacility WHERE (RoomID = '" + RoomID + "')";
        MyDataReader = MyCommand.ExecuteReader();
        ArrayList facList = new ArrayList();
        while (MyDataReader.Read())
        {
            facList.Add(MyDataReader.GetSqlValue(1).ToString());
        }
        MyDataReader.Close();
        MyDataReader = null;
        int count = 0;
        BulletedListFacilities.Items.Clear();
        foreach (string i in facList)
        {
            MyCommand.CommandText = "SELECT * FROM Facility WHERE (FacilityID = '" + i + "')";
            MyDataReader = MyCommand.ExecuteReader();
            while (MyDataReader.Read())
            {
                if (count == 0)
                {
                    Label12.Text = MyDataReader.GetSqlValue(1).ToString();
                }
                if (count == 1)
                {
                    Label13.Text = MyDataReader.GetSqlValue(1).ToString();
                }
                if (count > 1)
                {
                    BulletedListFacilities.Items.Add(MyDataReader.GetSqlValue(1).ToString());
                }
            }
            MyDataReader.Close();
            MyDataReader = null;
            count = count + 1;
        }
        MyCommand = null;
        MyConnection.Close();
        MyConnection = null;
        buildTable();
        
    }

    protected void buildTable()
    {
        for (int p = 2; p < 7; p++)
        {
            for (int q = 1; q < 10; q++)
            {
                Table1.Rows[p].Cells[q].BackColor = System.Drawing.Color.White;
            }

        }

        string RoomID = ListBoxRooms.SelectedItem.Text;
        System.Data.SqlClient.SqlConnection MyConnection;
        System.Data.SqlClient.SqlCommand MyCommand;
        System.Data.SqlClient.SqlDataReader MyDataReader;
        MyConnection = new System.Data.SqlClient.SqlConnection("Data Source=co-web-3.lboro.ac.uk;Initial Catalog=team17;User ID=team17;Password=g6g88fcv");
        MyConnection.Open();
        MyCommand = new System.Data.SqlClient.SqlCommand();
        MyCommand.Connection = MyConnection;
        
        string Command1 = "";

        if (DropDownWeeks0.SelectedValue == "All1")
        {
            Command1 = "SELECT DISTINCT TimeID, RequestID FROM RequestTime WHERE (Week < 13) AND (RequestID IN(SELECT RequestID FROM Request WHERE (Status = 'Allocated') AND (RoundID IN(SELECT RoundID FROM Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "'))))) AND RequestID IN(SELECT RequestID FROM RequestRoom WHERE RoomID = '"+ListBoxRooms.SelectedValue+"')";
        }
        if (DropDownWeeks0.SelectedValue == "All2")
        {
            Command1 = "SELECT DISTINCT TimeID, RequestID FROM RequestTime WHERE (RequestID IN(SELECT RequestID FROM Request WHERE (RequestID IN(SELECT RequestID FROM Request WHERE (Status = 'Allocated') AND (RoundID IN(SELECT RoundID FROM Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "'))))))) AND RequestID IN(SELECT RequestID FROM RequestRoom WHERE RoomID = '" + ListBoxRooms.SelectedValue + "')";
        }
        if (DropDownWeeks0.SelectedValue != "All1" && DropDownWeeks0.SelectedValue != "All2")
        {
            Command1 = "SELECT DISTINCT TimeID, RequestID FROM RequestTime WHERE (Week="+DropDownWeeks0.SelectedValue+") AND (RequestID IN(SELECT RequestID FROM Request WHERE (Week = " + DropDownWeeks0.SelectedValue + ") AND (RequestTime.RequestID IN(SELECT RequestID FROM Request WHERE (Status = 'Allocated') AND (RoundID IN(SELECT RoundID FROM Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "'))))))) AND RequestID IN(SELECT RequestID FROM RequestRoom WHERE RoomID = '" + ListBoxRooms.SelectedValue + "')";
        }


        MyCommand.CommandText = Command1; 
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

    protected void UpdateRoomSQL()
    {
        var RoomSQL = "SELECT DISTINCT RoomID FROM Room WHERE (RoomID != '')";
        if (DropDownListStyle.SelectedItem.Text == "All")
        {
        }
        else
        {
            RoomSQL = RoomSQL + " AND (RoomID IN(SELECT RoomID FROM RoomFacility WHERE (FacilityID='" + DropDownListStyle.SelectedValue + "'))) ";
        }

        if (DropDownListType.SelectedItem.Text == "All")
        {
        }
        else
        {
            RoomSQL = RoomSQL + " AND (RoomID IN(SELECT RoomID FROM RoomFacility WHERE (FacilityID='" + DropDownListType.SelectedValue + "'))) ";
        }

        for (int i = 0; i < CheckBoxListFacilities.Items.Count; i++)
        {
            if (CheckBoxListFacilities.Items[i].Selected)
            {
                RoomSQL = RoomSQL + " AND (RoomID IN(Select RoomID FROM RoomFacility WHERE (FacilityID = '" + CheckBoxListFacilities.Items[i].Value + "' ))) ";
            }
        }

        if (TextBoxCapacity.Text != "")
        {
            RoomSQL = RoomSQL + " AND (Capacity >='" + TextBoxCapacity.Text + "') ";
        }

        RoomCodes.SelectCommand = RoomSQL;
    }




    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        UpdateRoomSQL();
    }
    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {
        UpdateRoomSQL();
    }
    protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        UpdateRoomSQL();
    }
    protected void DropDownListType_SelectedIndexChanged(object sender, EventArgs e)
    {
        UpdateRoomSQL();
    }
    protected void DropDownListType_DataBound(object sender, EventArgs e)
    {
        DropDownListType.Items.Insert(0, "All");
    }
    protected void DropDownListStyle_DataBound(object sender, EventArgs e)
    {
        DropDownListStyle.Items.Insert(0, "All");
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        buildTable();
    }
    protected void DropDownSemester_SelectedIndexChanged(object sender, EventArgs e)
    {
        buildTable();
    }
    protected void DropDownWeeks0_SelectedIndexChanged(object sender, EventArgs e)
    {
        buildTable();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string roomid = Label8.Text;
        Response.Redirect("RoomBook.aspx?" + roomid);
    }
}
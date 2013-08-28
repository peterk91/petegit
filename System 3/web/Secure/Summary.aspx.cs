using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Summary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        titles1();
    }

    protected void titles1()
    {
        System.Data.SqlClient.SqlConnection MyConnection;
        System.Data.SqlClient.SqlCommand MyCommand;
        System.Data.SqlClient.SqlDataReader MyDataReader;
        MyConnection = new System.Data.SqlClient.SqlConnection("Data Source=co-web-3.lboro.ac.uk;Initial Catalog=team17;User ID=team17;Password=g6g88fcv");
        MyConnection.Open();
        MyCommand = new System.Data.SqlClient.SqlCommand();
        MyCommand.Connection = MyConnection;
        MyCommand.CommandText = "SELECT RequestID FROM Request WHERE (Status = 'Pending') AND (UserID = '" + Session["login_name"] + "') AND (RoundID IN (SELECT RoundID From Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "')))";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            if (MyDataReader.GetSqlValue(0).ToString() == "Null")
            {
                Label2.Visible = false;
            }
            else
            {
                Label2.Visible = true;
            }
           }
        MyDataReader.Close();
        MyDataReader = null;
        MyCommand.CommandText = "SELECT RequestID FROM Request WHERE (Status = 'Allocated') AND (UserID = '" + Session["login_name"] + "') AND (RoundID IN (SELECT RoundID From Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "')))";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
        {
            if (MyDataReader.GetSqlValue(0).ToString() == "Null")
            {
                Label1.Visible = false;
            }
            else
            {
                Label1.Visible = true;
            }
        }
        MyDataReader.Close();
        MyDataReader = null;
        MyCommand.CommandText = "SELECT RequestID FROM Request WHERE (Status = 'Denied') AND (UserID = '" + Session["login_name"] + "') AND (RoundID IN (SELECT RoundID From Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "')))";
        MyDataReader = MyCommand.ExecuteReader();
        while (MyDataReader.Read())
            if (MyDataReader.GetSqlValue(0).ToString() == "Null")
            {
                Label3.Visible = false;
            }
            else
            {
                Label3.Visible = true;
            }
        MyDataReader.Close();
        MyDataReader = null;
    }
    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {

    }
    protected void SqlDataSource1_DataBinding(object sender, EventArgs e)
    {

    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        buildTable();
        titles1();
    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {

        Response.Redirect("~/Secure/edit.aspx");
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedValue == "List View")
        {
            Panel1.Visible = true;
            Panel2.Visible = false;
        }
        else
        {
            buildTable();
            Panel1.Visible = false;
            Panel2.Visible = true;
        }
    }


    protected void buildTable()
    {
        for (int p = 2; p < 7; p++)
        {
            for (int q = 1; q < 10; q++)
            {
                Table2.Rows[p].Cells[q].Text = "";
                Table2.Rows[p].Cells[q].BackColor = System.Drawing.Color.White;
            }

        }

        System.Data.SqlClient.SqlConnection MyConnection;
        System.Data.SqlClient.SqlCommand MyCommand;
        System.Data.SqlClient.SqlDataReader MyDataReader;
        MyConnection = new System.Data.SqlClient.SqlConnection("Data Source=co-web-3.lboro.ac.uk;Initial Catalog=team17;User ID=team17;Password=g6g88fcv");
        MyConnection.Open();
        MyCommand = new System.Data.SqlClient.SqlCommand();
        MyCommand.Connection = MyConnection;
        
        if (RadioButtonList2.SelectedValue == "Allocated" || RadioButtonList2.SelectedValue == "Both")
        {
            string Command1 ="";

            if (DropDownWeeks0.SelectedValue == "All1")
            {
                Command1 = "SELECT DISTINCT RequestTime.TimeID, Request.RequestID, Request.ModuleID FROM RequestTime INNER JOIN Request ON RequestTime.RequestID = Request.RequestID WHERE (RequestTime.Week < 13) AND (RequestTime.RequestID IN(SELECT RequestID FROM Request WHERE (UserID = '" + Session["login_name"] + "') AND (Status = 'Allocated') AND (RoundID IN(SELECT RoundID FROM Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "')))))";
            }
            if (DropDownWeeks0.SelectedValue == "All2")
            {
                Command1 = "SELECT DISTINCT RequestTime.TimeID, Request.RequestID, Request.ModuleID FROM RequestTime INNER JOIN Request ON RequestTime.RequestID = Request.RequestID WHERE (RequestTime.RequestID IN(SELECT RequestID FROM Request WHERE (UserID = '" + Session["login_name"] + "') AND (Status = 'Allocated') AND (RoundID IN(SELECT RoundID FROM Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "')))))";
            }
            if (DropDownWeeks0.SelectedValue != "All1" && DropDownWeeks0.SelectedValue != "All2")
            {
                Command1 = "SELECT DISTINCT RequestTime.TimeID, Request.RequestID, Request.ModuleID FROM RequestTime INNER JOIN Request ON RequestTime.RequestID = Request.RequestID WHERE (RequestTime.Week = "+DropDownWeeks0.SelectedValue+") AND (RequestTime.RequestID IN(SELECT RequestID FROM Request WHERE (UserID = '" + Session["login_name"] + "') AND (Status = 'Allocated') AND (RoundID IN(SELECT RoundID FROM Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "')))))";
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
                            Table2.Rows[2].Cells[a + 1].BackColor = System.Drawing.ColorTranslator.FromHtml("#EBEBEB");
                            Table2.Rows[2].Cells[a + 1].Text += "<span style='color:Green'><b>ID</b> - " + MyDataReader.GetSqlValue(1).ToString() + ", <b>Mod</b> - ";
                            Table2.Rows[2].Cells[a + 1].Text += MyDataReader.GetSqlValue(2).ToString();
                            Table2.Rows[2].Cells[a + 1].Text += "<a href='view.aspx?" + MyDataReader.GetSqlValue(1).ToString() + "'>(View)</a><br /></span>";
                        }

                        if (a > 8 && a < 18)
                        {
                            int b = (a - 9);
                            Table2.Rows[3].Cells[b + 1].BackColor = System.Drawing.ColorTranslator.FromHtml("#EBEBEB");
                            Table2.Rows[3].Cells[b + 1].Text += "<span style='color:Green'><b>ID</b> - " + MyDataReader.GetSqlValue(1).ToString() + ", <b>Mod</b> - ";
                            Table2.Rows[3].Cells[b + 1].Text += MyDataReader.GetSqlValue(2).ToString();
                            Table2.Rows[3].Cells[b + 1].Text += "<a href='view.aspx?" + MyDataReader.GetSqlValue(1).ToString() + "'>(View)</a><br /></span>";
                        }

                        if (a > 17 && a < 27)
                        {
                            int b = (a - 18);
                            Table2.Rows[4].Cells[b + 1].BackColor = System.Drawing.ColorTranslator.FromHtml("#EBEBEB");
                            Table2.Rows[4].Cells[b + 1].Text += "<span style='color:Green'><b>ID</b> - " + MyDataReader.GetSqlValue(1).ToString() + ", <b>Mod</b> - ";
                            Table2.Rows[4].Cells[b + 1].Text += MyDataReader.GetSqlValue(2).ToString();
                            Table2.Rows[4].Cells[b + 1].Text += "<a href='view.aspx?" + MyDataReader.GetSqlValue(1).ToString() + "'>(View)</a><br /></span>";
                        }

                        if (a > 26 && a < 36)
                        {
                            int b = (a - 27);
                            Table2.Rows[5].Cells[b + 1].BackColor = System.Drawing.ColorTranslator.FromHtml("#EBEBEB");
                            Table2.Rows[5].Cells[b + 1].Text += "<span style='color:Green'><b>ID</b> - " + MyDataReader.GetSqlValue(1).ToString() + ", <b>Mod</b> - ";
                            Table2.Rows[5].Cells[b + 1].Text += MyDataReader.GetSqlValue(2).ToString();
                            Table2.Rows[5].Cells[b + 1].Text += "<a href='view.aspx?" + MyDataReader.GetSqlValue(1).ToString() + "'>(View)</a><br /></span>";
                        }

                        if (a > 35 && a < 45)
                        {
                            int b = (a - 36);
                            Table2.Rows[6].Cells[b + 1].BackColor = System.Drawing.ColorTranslator.FromHtml("#EBEBEB");
                            Table2.Rows[6].Cells[b + 1].Text += "<span style='color:Green'><b>ID</b> - " + MyDataReader.GetSqlValue(1).ToString() + ", <b>Mod</b> - ";
                            Table2.Rows[6].Cells[b + 1].Text += MyDataReader.GetSqlValue(2).ToString();
                            Table2.Rows[6].Cells[b + 1].Text += "<a href='view.aspx?" + MyDataReader.GetSqlValue(1).ToString() + "'>(View)</a><br /></span>";
                        }

                    }
                }
            }
            MyDataReader.Close();
            MyDataReader = null;

        }

        if (RadioButtonList2.SelectedValue == "Pending" || RadioButtonList2.SelectedValue == "Both")
        {

            string Command1 = "";

            if (DropDownWeeks0.SelectedValue == "All1")
            {
                Command1 = "SELECT DISTINCT RequestTime.TimeID, Request.RequestID, Request.ModuleID FROM RequestTime INNER JOIN Request ON RequestTime.RequestID = Request.RequestID WHERE (RequestTime.Week < 13) AND (RequestTime.RequestID IN(SELECT RequestID FROM Request WHERE (UserID = '" + Session["login_name"] + "') AND (Status = 'Pending') AND (RoundID IN(SELECT RoundID FROM Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "')))))";
            }
            if (DropDownWeeks0.SelectedValue == "All2")
            {
                Command1 = "SELECT DISTINCT RequestTime.TimeID, Request.RequestID, Request.ModuleID FROM RequestTime INNER JOIN Request ON RequestTime.RequestID = Request.RequestID WHERE (RequestTime.RequestID IN(SELECT RequestID FROM Request WHERE (UserID = '" + Session["login_name"] + "') AND (Status = 'Pending') AND (RoundID IN(SELECT RoundID FROM Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "')))))";
            }
            if (DropDownWeeks0.SelectedValue != "All1" && DropDownWeeks0.SelectedValue != "All2")
            {
                Command1 = "SELECT DISTINCT RequestTime.TimeID, Request.RequestID, Request.ModuleID FROM RequestTime INNER JOIN Request ON RequestTime.RequestID = Request.RequestID WHERE (RequestTime.Week = " + DropDownWeeks0.SelectedValue + ") AND (RequestTime.RequestID IN(SELECT RequestID FROM Request WHERE (UserID = '" + Session["login_name"] + "') AND (Status = 'Pending') AND (RoundID IN(SELECT RoundID FROM Round WHERE (SemesterID = '" + DropDownList1.SelectedValue + "')))))";
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
                            Table2.Rows[2].Cells[a + 1].BackColor = System.Drawing.ColorTranslator.FromHtml("#EBEBEB");
                            Table2.Rows[2].Cells[a + 1].Text += "<span style='color:Orange'><b>ID</b> - " + MyDataReader.GetSqlValue(1).ToString() + ", <b>Mod</b> - ";
                            Table2.Rows[2].Cells[a + 1].Text += MyDataReader.GetSqlValue(2).ToString();
                            Table2.Rows[2].Cells[a + 1].Text += "<a href='view.aspx?" + MyDataReader.GetSqlValue(1).ToString() + "'>(View)</a><br /></span>";
                        }

                        if (a > 8 && a < 18)
                        {
                            int b = (a - 9);
                            Table2.Rows[3].Cells[b + 1].BackColor = System.Drawing.ColorTranslator.FromHtml("#EBEBEB");
                            Table2.Rows[3].Cells[b + 1].Text += "<span style='color:Orange'><b>ID</b> - " + MyDataReader.GetSqlValue(1).ToString() + ", <b>Mod</b> - ";
                            Table2.Rows[3].Cells[b + 1].Text += MyDataReader.GetSqlValue(2).ToString();
                            Table2.Rows[3].Cells[b + 1].Text += "<a href='view.aspx?" + MyDataReader.GetSqlValue(1).ToString() + "'>(View)</a><br /></span>";
                        }

                        if (a > 17 && a < 27)
                        {
                            int b = (a - 18);
                            Table2.Rows[4].Cells[b + 1].BackColor = System.Drawing.ColorTranslator.FromHtml("#EBEBEB");
                            Table2.Rows[4].Cells[b + 1].Text += "<span style='color:Orange'><b>ID</b> - " + MyDataReader.GetSqlValue(1).ToString() + ", <b>Mod</b> - ";
                            Table2.Rows[4].Cells[b + 1].Text += MyDataReader.GetSqlValue(2).ToString();
                            Table2.Rows[4].Cells[b + 1].Text += "<a href='view.aspx?" + MyDataReader.GetSqlValue(1).ToString() + "'>(View)</a><br /></span>";
                        }

                        if (a > 26 && a < 36)
                        {
                            int b = (a - 27);
                            Table2.Rows[5].Cells[b + 1].BackColor = System.Drawing.ColorTranslator.FromHtml("#EBEBEB");
                            Table2.Rows[5].Cells[b + 1].Text += "<span style='color:Orange'><b>ID</b> - " + MyDataReader.GetSqlValue(1).ToString() + ", <b>Mod</b> - ";
                            Table2.Rows[5].Cells[b + 1].Text += MyDataReader.GetSqlValue(2).ToString();
                            Table2.Rows[5].Cells[b + 1].Text += "<a href='view.aspx?" + MyDataReader.GetSqlValue(1).ToString() + "'>(View)</a><br /></span>";
                        }

                        if (a > 35 && a < 45)
                        {
                            int b = (a - 36);
                            Table2.Rows[6].Cells[b + 1].BackColor = System.Drawing.ColorTranslator.FromHtml("#EBEBEB");
                            Table2.Rows[6].Cells[b + 1].Text += "<span style='color:Orange'><b>ID</b> - " + MyDataReader.GetSqlValue(1).ToString() + ", <b>Mod</b> - ";
                            Table2.Rows[6].Cells[b + 1].Text += MyDataReader.GetSqlValue(2).ToString();
                            Table2.Rows[6].Cells[b + 1].Text += "<a href='view.aspx?" + MyDataReader.GetSqlValue(1).ToString() + "'>(View)</a><br /></span>";
                        }

                    }
                }
            }
            MyDataReader.Close();
            MyDataReader = null;
        }

    }

    protected void RadioButtonList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        buildTable();
    }
    protected void DropDownWeeks0_SelectedIndexChanged(object sender, EventArgs e)
    {
        buildTable();
    }
}
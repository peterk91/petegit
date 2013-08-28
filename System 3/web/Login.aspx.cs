using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class web_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        string strCon = ConfigurationManager.ConnectionStrings["LoginConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LoginConnectionString"].ConnectionString);

        //using (SqlConnection con = new SqlConnection(strCon))
        {
            using (SqlCommand cmdStr = new SqlCommand("SELECT TOP(1) * FROM [Department] WHERE DepartmentID = '" + Login1.UserName +
                                                    "' AND DepartmentPassword = '" + Login1.Password + "'", con))
            {
                try
                {
                    con.Open();
                    if (cmdStr.ExecuteReader().HasRows)
                    {
                        e.Authenticated = true;
                        Session["login_name"] = Login1.UserName.ToString();
                        Session.Timeout = 40;

                        return;
                    }
                    else
                    {
                        Session.Abandon();
                    }
                }
                finally
                {
                    con.Close();
                    
                }
            }
            
        }
    }
}
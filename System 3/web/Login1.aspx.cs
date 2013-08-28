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

        // Making the inputs into strings to avoid SQL Injection.

        String Login_String = DropList5.SelectedValue;
        String Password_String = Login1.Password;

        // Checking the SQL database with given password with the username.
        
        {
            using (SqlCommand cmdStr = new SqlCommand("SELECT TOP(1) * FROM [Department] WHERE DepartmentID = '" + Login_String +
                                                    "' AND DepartmentPassword = '" + Password_String + "'", con))
            {
                try
                {
                    con.Open();
                    if (cmdStr.ExecuteReader().HasRows)
                    {
                        e.Authenticated = true;
                        
                        // The session name is equals to the username.

                        Session["login_name"] = DropList5.SelectedValue.ToString();
                        Session.Timeout = 3000;
                        return;
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
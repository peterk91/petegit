using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Secure_Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["login_name"] != null)
        {
            
        }
        else
        {
            Response.Redirect("~/Login.aspx");
            //Session.Abandon();
            // sign out the user                   
            //System.Web.Security.FormsAuthentication.SignOut();
            // redirect to the login page
            //System.Web.Security.FormsAuthentication.RedirectToLoginPage();
        }

    }
    protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
    {


    }
}